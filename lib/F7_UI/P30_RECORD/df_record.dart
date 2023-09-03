import '/F0_BASIC/common_import.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'dart:developer' as dev;

//------------------------------------------------------------------------------
//  DateTime 클래스에 해당 달의 몇번째 주 인지 계산하는 메소드 extension
//------------------------------------------------------------------------------
extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}

//------------------------------------------------------------------------------
// Record Chart 를 그릴때 필요한 data 및 설정 값을 묶어둔 클래스
//------------------------------------------------------------------------------
class GraphData {
  List<String> xLabelList = <String>[];
  List<List<double>> yDataListBundle = <List<double>>[];
  double visibleMaximum = 0;
  double visibleMinimum = 0;
}

//------------------------------------------------------------------------------
//통계 그래프에서 1개의 bar 를 표현하는데 사용되는 클래스
//------------------------------------------------------------------------------
class BarDataBucket {
  int id = 0;
  int startDate =
      0; // 버킷이 포함하는 날짜의 시작 값 ( 일 단위 그래프일 경우 startDate 와 endDate 가 동일 )
  int endDate = 0; // 버킷이 포함하는 날짜의 끝 값 ( 일 단위 그래프일 경우 startDate 와 endDate 가 동일 )
  int dateInterval = 0; // startDate 와 endDate 까지의 날짜 수
  int weekNum = 0; // 해당 달의 몇번째 주
  List<int> indexListInDb =
      <int>[]; // 버킷의 날짜 구간에 포함되는 날짜가 db에 있을 경우 그 index 값을 저장
  double avgValue = 0.0; // 그래프에 표시하려는 data 값 (최대근련, 운동량, 운동시간 등)
  double sumOfValue = 0.0;
  double maxValue = 0.0; // 최대 근력값을 저장하는 용도

  //BarDataBucket();
  BarDataBucket({
    this.id = 0,
    this.startDate = 0,
    this.endDate = 0,
    this.dateInterval = 0,
    this.weekNum = 0,
  });

  // deep copy 에 사용되는 method
  factory BarDataBucket.clone(BarDataBucket barDataBucket) {
    return BarDataBucket(
      id: barDataBucket.id,
      startDate: barDataBucket.startDate,
      endDate: barDataBucket.endDate,
      dateInterval: barDataBucket.dateInterval,
      weekNum: barDataBucket.weekNum,
    );
  }
}

class BucketInfo {
  DateTime startDate = DateTime(0, 0, 0); // 버킷의 시작 날짜
  int weekNum = 0;
  int bucketLength = 0; // 버킷의 시작날짜로 부터 오늘까지의 나타내는데 필요한 버킷 수
  BucketInfo();
}

//------------------------------------------------------------------------------
// 그래프 TimePeriod 변경 메소드 (1주, 1달, 3달, 6달, 1년 버튼클릭시 호출)
//------------------------------------------------------------------------------
Future<void> changeGraphTimePeriod(timePeriod) async {
  gvRecord.graphTimePeriod.value = timePeriod; // 변경된 timePeriod 값을 전역변수에 저장
  await updateGraphData(
      timePeriod: timePeriod); // 변경된 timePeriod 값으로 그래프 data 생성
  gvRecord.graphDataUpdateCount
      .value++; // 그래프 data 생성이 끝나면 화면 업데이트를 알리는 observable 변수 수정

  // TimePeriod 설정 값을 메모리에 저장해서 다음번 앱을 실행했을때에도 동일하게 적용
  gv.spMemory.write('graphTimePeriodIndex', gvRecord.graphTimePeriod.value.index);
}

//------------------------------------------------------------------------------
// 그래프 DataType 변경 메소드
//------------------------------------------------------------------------------
Future<void> changeGraphDataType(graphDataType) async {
  gvRecord.graphDataType.value = graphDataType; // 변경된 DataType 값을 전역변수에 저장
  await updateGraphData(
      graphDataType: graphDataType); // 변경된 timePeriod 값으로 그래프 data 생성
  gvRecord.graphDataUpdateCount
      .value++; // 그래프 data 생성이 끝나면 화면 업데이트를 알리는 observable 변수 수정
}

//------------------------------------------------------------------------------
// 근육 변경 메소드 (1주, 1달, 3달, 6달, 1년 버튼클릭시 호출)
//------------------------------------------------------------------------------
Future<void> changeGraphMuscle() async {
  await updateGraphData(); // 변경된 timePeriod 값으로 그래프 data 생성
  gvRecord.graphDataUpdateCount
      .value++; // 그래프 data 생성이 끝나면 화면 업데이트를 알리는 observable 변수 수정
}

//------------------------------------------------------------------------------
// 그래프 데이터 업데이트 메소드
// Todo: 근육, dataType 에 대해서도 input parameter 로 추가해야함
//------------------------------------------------------------------------------
Future<void> updateGraphData(
    {GraphTimePeriod timePeriod = GraphTimePeriod.aWeek,
    GraphDataType graphDataType = GraphDataType.mvc}) async {
  // bucket list 생성
  gvRecord.barDataBuckets =
      makeBarDataBuckets(timePeriod: gvRecord.graphTimePeriod.value);
  // Todo: 위에서 계산한 buckets 를 필요한만큼 deep copy 해서 사용해아함

  //  DB 데이터로 bucket list 채우기
  List<List<BarDataBucket>> bundleOfBarDataBuckets = fillBucketFromDB(
      dataType: gvRecord.graphDataType.value,
      barDataBucketList: gvRecord.barDataBuckets);

  // 완성된 bucket 으로 그래프 데이터 생성
  gvRecord.graphData = makeGraphData(
      timePeriod: gvRecord.graphTimePeriod.value,
      bundleOfBarDataBuckets: bundleOfBarDataBuckets);
  }

//------------------------------------------------------------------------------
// BarDataBuckets 생성하는 메소드 (그래프의 x 축을 만드는 기준이 됨)
//------------------------------------------------------------------------------
List<BarDataBucket> makeBarDataBuckets({required GraphTimePeriod timePeriod}) {
  List<BarDataBucket> barDataBuckets = <BarDataBucket>[];
  DateTime today = DateTime.now(); // 오늘 날짜
  int firstDateInDB = (gv.dbMuscleContents.dateStats.isEmpty)
      ? int.parse(DateFormat('yyyyMMdd').format(today))
      : gv.dbMuscleContents.dateStats[0];
  BucketInfo bucketInfo =
      calculateBucketInfo(timePeriod, firstDateInDB); // bucket 길이 계산

  DateTime startDate;
  DateTime endDate;

  //설정된 그래프 기간(타입)에 따라서 barDataBuckets 마다 해당 날짜(구간)를 입력
  if (timePeriod == GraphTimePeriod.aWeek ||
      timePeriod == GraphTimePeriod.aMonth) {
    // 그래프에서 각각의 bar data 를 저장할 버킷을 필요한 갯수만큼 생성
    barDataBuckets =
        List.generate(bucketInfo.bucketLength, (index) => BarDataBucket());

    DateTime firstDate = DateTime(
        today.year, today.month, today.day - (bucketInfo.bucketLength) + 1);
    for (int index = 0; index < bucketInfo.bucketLength; index++) {
      barDataBuckets[index].id = index;
      startDate =
          DateTime(firstDate.year, firstDate.month, firstDate.day + index);
      String startDateAsString = DateFormat('yyyyMMdd').format(startDate);
      barDataBuckets[index].startDate = int.parse(startDateAsString);
      barDataBuckets[index].endDate = int.parse(startDateAsString);
      barDataBuckets[index].dateInterval = 1;
    }
  } else if (timePeriod == GraphTimePeriod.threeMonths ||
      timePeriod == GraphTimePeriod.sixMonths) {
    barDataBuckets =
        List.generate(bucketInfo.bucketLength, (index) => BarDataBucket());
    DateTime firstDate = bucketInfo.startDate;
    int preMonth =
        (bucketInfo.startDate.subtract(const Duration(days: 1))).month;
    int weekCount = bucketInfo.weekNum; // 해당 달의 몇번째 주 인지 count 하는 변수
    // month 단위로 for 문을 반복
    for (int index = 0; index < bucketInfo.bucketLength; index++) {
      barDataBuckets[index].id = index;
      startDate = firstDate.add(Duration(days: 7 * index));
      String startDateAsString = DateFormat('yyyyMMdd').format(startDate);
      barDataBuckets[index].startDate = int.parse(startDateAsString);

      endDate =
          (startDate.add(const Duration(days: 6)).difference(today).inDays) > 0
              ? today
              : startDate.add(const Duration(days: 6));
      String endDateAsString = DateFormat('yyyyMMdd').format(endDate);
      barDataBuckets[index].endDate = int.parse(endDateAsString);

      int startMonth = (((barDataBuckets[index].startDate) % 10000) ~/ 100);
      int endMonth = (((barDataBuckets[index].endDate) % 10000) ~/ 100);
      barDataBuckets[index].weekNum = weekCount;

      if (startMonth != preMonth && preMonth != 0) {
        // 저번주차 마지막날과 이번주차 첫날 사이에 월이 바뀐 경우
        weekCount = 1;
        barDataBuckets[index].weekNum = weekCount;
      } else if (startMonth != endMonth) {
        // 이번주 시작과 마지막날 사이에 월이 바뀐 경우
        weekCount = 1;
        barDataBuckets[index].weekNum = weekCount;
      }
      barDataBuckets[index].dateInterval =
          endDate.difference(startDate).inDays + 1;
      weekCount++;
      preMonth = endMonth;
    }
  } else if (timePeriod == GraphTimePeriod.aYear) {
    // 그래프에서 각각의 bar data 를 저장할 버킷을 필요한 갯수만큼 생성
    barDataBuckets =
        List.generate(bucketInfo.bucketLength, (index) => BarDataBucket());

    DateTime firstDate =
        DateTime(today.year, today.month - bucketInfo.bucketLength + 1, 1);
    for (int index = 0; index < bucketInfo.bucketLength; index++) {
      barDataBuckets[index].id = index;
      startDate = DateTime(firstDate.year, firstDate.month + index, 1);
      String startDateAsString = DateFormat('yyyyMMdd').format(startDate);
      barDataBuckets[index].startDate = int.parse(startDateAsString);
      endDate = DateTime(firstDate.year, firstDate.month + index + 1, 0);
      String endDateAsString = DateFormat('yyyyMMdd').format(endDate);
      barDataBuckets[index].endDate = int.parse(endDateAsString);
      barDataBuckets[index].dateInterval =
          endDate.difference(startDate).inDays + 1;
    }
  } else {
    if (kDebugMode) {
      print(
          'df_record.dart :: preprocessRecordChart2( ) : not available type of GraphTimePeriod');
    }
  }
  return barDataBuckets;
}

//------------------------------------------------------------------------------
// 그래프를 그리기 위해 몇개의 버킷을 만들지 판단하는 메소드
BucketInfo calculateBucketInfo(GraphTimePeriod timePeriod, int firstDateInDB) {
  BucketInfo bucketInfo = BucketInfo();
  DateTime today = DateTime.now();

  if (timePeriod == GraphTimePeriod.aWeek) {
    int defaultLength = visibleDataNumber['aWeek']!;
    //오늘로부터 최소 bucket 수만큼의 과거 날짜
    DateTime startDateOfFirstBucket =
        DateTime(today.year, today.month, today.day - defaultLength + 1);
    int startDateOfFirstBucketAsInt =
        int.parse(DateFormat('yyyyMMdd').format(startDateOfFirstBucket));

    // DB의 data 날짜 시작값이 그래프의 default 구간보다 과거라면, 그래프 구간을 DB 구간에 맞춤
    if (firstDateInDB < startDateOfFirstBucketAsInt) {
      int year = firstDateInDB ~/ 10000;
      int month = (firstDateInDB % 10000) ~/ 100;
      int day = firstDateInDB % 100;
      bucketInfo.startDate = DateTime(year, month, day);
      int newBucketLength = today.difference(bucketInfo.startDate).inDays + 1;
      bucketInfo.bucketLength = newBucketLength;
    } else {
      bucketInfo.startDate = startDateOfFirstBucket;
      bucketInfo.bucketLength = defaultLength;
    }
  } else if (timePeriod == GraphTimePeriod.aMonth) {
    int defaultLength = visibleDataNumber['aMonth']!;
    DateTime startDateOfFirstBucket =
        DateTime(today.year, today.month, today.day - defaultLength + 1);
    int startDateOfFirstBucketAsInt =
        int.parse(DateFormat('yyyyMMdd').format(startDateOfFirstBucket));
    // DB의 data 날짜 시작값이 그래프의 default 구간보다 과거라면, 그래프 구간을 DB 구간에 맞춤
    if (firstDateInDB < startDateOfFirstBucketAsInt) {
      int year = firstDateInDB ~/ 10000;
      int month = (firstDateInDB % 10000) ~/ 100;
      int day = firstDateInDB % 100;
      bucketInfo.startDate = DateTime(year, month, day);
      int newBucketLength = today.difference(bucketInfo.startDate).inDays;
      bucketInfo.bucketLength = newBucketLength;
    } else {
      bucketInfo.startDate = startDateOfFirstBucket;
      bucketInfo.bucketLength = defaultLength;
    }
  } else if (timePeriod == GraphTimePeriod.threeMonths) {
    int defaultLength = visibleDataNumber['threeMonths']!;
    DateTime dateBeforeDefaultLength =
        today.subtract(Duration(days: (defaultLength - 1) * 7));
    int weekDayOfDate = dateBeforeDefaultLength.weekday;
    DateTime startDateOfFirstBucket =
        dateBeforeDefaultLength.subtract(Duration(days: weekDayOfDate - 1));
    int startDateOfFirstBucketAsInt =
        int.parse(DateFormat('yyyyMMdd').format(startDateOfFirstBucket));

    if (firstDateInDB < startDateOfFirstBucketAsInt) {
      int year = firstDateInDB ~/ 10000;
      int month = (firstDateInDB % 10000) ~/ 100;
      int day = firstDateInDB % 100;

      // Db의 날짜가 default 값보다 과거이므로 DB 첫번째 날짜를 bucket 의 시작으로 계산
      DateTime dateTimeOfFirstDateInDB = DateTime(year, month, day);
      int weekdayOfFirstDateInDB = dateTimeOfFirstDateInDB.weekday;
      DateTime startDateOfNewBucket = dateTimeOfFirstDateInDB
          .subtract(Duration(days: weekdayOfFirstDateInDB - 1));
      int diffDays = today.difference(startDateOfNewBucket).inDays;
      int newBucketLength = (diffDays / 7).ceil();
      // 과거의 월요일 부터 7일로 나눌 때 1일(월요일)의 7일 뒤는 8일(월요일), 즉 새로운 주가 시작된다. 따라서 7의 배수일때는 + 1
      if (diffDays % 7 == 0) {
        newBucketLength = newBucketLength + 1;
      }
      bucketInfo.startDate = startDateOfNewBucket;
      bucketInfo.bucketLength = newBucketLength;
    } else {
      bucketInfo.startDate = startDateOfFirstBucket;
      bucketInfo.bucketLength = defaultLength;
    }
    bucketInfo.weekNum = bucketInfo.startDate.weekOfMonth;
  } else if (timePeriod == GraphTimePeriod.sixMonths) {
    int defaultLength = visibleDataNumber['sixMonths']!;
    DateTime dateBeforeDefaultLength =
        today.subtract(Duration(days: (defaultLength - 1) * 7));
    int weekDayOfDate = dateBeforeDefaultLength.weekday;
    DateTime startDateOfFirstBucket =
        dateBeforeDefaultLength.subtract(Duration(days: weekDayOfDate - 1));
    int startDateOfFirstBucketAsInt =
        int.parse(DateFormat('yyyyMMdd').format(startDateOfFirstBucket));

    if (firstDateInDB < startDateOfFirstBucketAsInt) {
      int year = firstDateInDB ~/ 10000;
      int month = (firstDateInDB % 10000) ~/ 100;
      int day = firstDateInDB % 100;

      // Db의 날짜가 default 값보다 작으므로 DB 첫번째 날짜의 주로 계산
      DateTime dateTimeOfFirstDateInDB = DateTime(year, month, day);
      int weekdayOfFirstDateInDB = dateTimeOfFirstDateInDB.weekday;
      DateTime startDateOfNewBucket = dateTimeOfFirstDateInDB
          .subtract(Duration(days: weekdayOfFirstDateInDB - 1));
      int diffDays = today.difference(startDateOfNewBucket).inDays;
      int newBucketLength = (diffDays / 7).ceil();
      // 과거의 월요일 부터 7일로 나눌 때 1일(월요일)의 7일 뒤는 8일(월요일), 즉 새로운 주가 시작된다. 따라서 7의 배수일때는 + 1
      if (diffDays % 7 == 0) {
        newBucketLength = newBucketLength + 1;
      }
      bucketInfo.startDate = startDateOfNewBucket;
      bucketInfo.bucketLength = newBucketLength;
    } else {
      bucketInfo.startDate = startDateOfFirstBucket;
      bucketInfo.bucketLength = defaultLength;
    }
    bucketInfo.weekNum = bucketInfo.startDate.weekOfMonth;
  } else if (timePeriod == GraphTimePeriod.aYear) {
    int defaultLength = visibleDataNumber['aYear']!;
    DateTime startDateOfFirstBucket =
        DateTime(today.year, today.month - defaultLength + 1, 1);
    int startDateOfFirstBucketAsInt =
        int.parse(DateFormat('yyyyMMdd').format(startDateOfFirstBucket));
    // DB의 data 날짜 시작값이 그래프의 default 구간보다 과거라면, 그래프 구간을 DB 구간에 맞춤
    if (firstDateInDB < startDateOfFirstBucketAsInt) {
      int year = firstDateInDB ~/ 10000;
      int month = (firstDateInDB % 10000) ~/ 100;
      int newBucketLength =
          (today.year - year) * 12 - (month - 1) + today.month;
      bucketInfo.startDate = DateTime(year, month, 1);
      bucketInfo.bucketLength = newBucketLength;
    } else {
      bucketInfo.startDate = startDateOfFirstBucket;
      bucketInfo.bucketLength = defaultLength;
    }
  } else {
    if (kDebugMode) {
      print('Not Available TimePeriod');
    }
  }
  return bucketInfo;
}

//------------------------------------------------------------------------------
// DB data 를 Buckets 의 날짜 구간에 맞게 Buckets 에 입력하는 메소드
// - 입력된 data type 에 따라 그래프에 그려질 선의 수가 결정되고, 따라서 선의 수에 따라 barDataBucketList 를 deep copy 해서 생성
//------------------------------------------------------------------------------
List<List<BarDataBucket>> fillBucketFromDB(
    {required GraphDataType dataType,
    required List<BarDataBucket> barDataBucketList}) {
  DbMuscleContents muscleContent = gv.dbMuscleContents; // 현재 설정된 근육 데이터
  int dBDataLength = muscleContent.dateStats.length; // DB에 날짜 정보 리스트의 길이
  List<List<BarDataBucket>> barDataBucketsBundle = []; // 메소드 실행 결과 값을 저장하는 변수

  // graphDataType 에 따라 계산에 사용할 값을 valueListInDB 에 입력
  List<List<double>?> valueListBundle = getDataValueList(dataType);

  // for(int index=0; index < valueListBundle.length ; index++) {
  //   print(
  //       'df_record.dart :: fillBucketFromDB() : valueListBundle[$index]=${valueListBundle[index]} ');
  // }

  // 그래프에 그릴 선의 수 만큼 barDataBuckets 를 초기화(함수 인자로 전달 받은 것으로)하여 준비
  for (int i = 0; i < valueListBundle.length; i++) {
    barDataBucketsBundle
        .add(barDataBucketList.map((e) => BarDataBucket.clone(e)).toList());
  }

  // 데이터가 하나도 없다면 프로세스 종료 (Case0 : 데이터 없음)
  bool isDataEmpty = muscleContent.dateStats.isEmpty;
  if (isDataEmpty == true) {
    return barDataBucketsBundle;
  }

  int lastDateInDB =
      muscleContent.dateStats[dBDataLength - 1]; // DB에 저장되어있는 마지막 날짜

  // db에 저장된 마지막 date 데이터가 buckets 구간에 포함되지 않으면 프로세스 종료 (Case1: 기간이 중첩되지 않음)
  if (lastDateInDB < barDataBucketList[0].startDate) {
    return barDataBucketsBundle;
  }

  // data type 에 따라 그래프를 그리는데 필요한 line 의 수가 2개 이상일 때가 있으므로, 이것을 valueListBundle 를 보고 판단
  for (int valueListIndex = 0;
      valueListIndex < valueListBundle.length;
      valueListIndex++) {
    List<BarDataBucket> barDataBuckets = barDataBucketsBundle[valueListIndex];

    // DB에 저장된 첫번째 날짜부터 꺼내서 해당되는 bucket 에 집어 넣기
    int startingIndex = 0; // 바로전 dB 데이터가 어떤 bucket 에 입력되었다면 그 버켓 인덱스 저장
    for (int dbIndex = 0; dbIndex < dBDataLength; dbIndex++) {
      int dateAsInt = muscleContent.dateStats[dbIndex]; // db 에서 date 데이터를 가져옴

      //현재 데이터가 buckets 의 전구간 중에 포함 되는지 체크 (case4 일때, 빠르게 skip)
      if (dateAsInt >= barDataBuckets[0].startDate ||
          dateAsInt <= barDataBuckets[barDataBuckets.length - 1].endDate) {
        // 현재 date 데이터가 어느 bucket 의 구간에 포함되는지 체크
        for (int bucketIndex = startingIndex;
            bucketIndex < barDataBuckets.length;
            bucketIndex++) {
          if (barDataBuckets[bucketIndex].startDate <= dateAsInt &&
              barDataBuckets[bucketIndex].endDate >= dateAsInt) {
            //------------------------------------------------------------------
            // 현재 버킷[barDataBuckets[]]에 대해서 새로운 값(valueBundle[][])이 들어왔을 때 최대, 총합, 평균을 계산하는 함수 호출
            calculateYData(dataType, barDataBuckets[bucketIndex],
                valueListBundle[valueListIndex]![dbIndex]);
            barDataBuckets[bucketIndex].indexListInDb = [
              ...barDataBuckets[bucketIndex].indexListInDb,
              dbIndex
            ];
            // 현재 저장한 bucket index 를 기억했다가 다음 DB 데이터는 여기서부터 검색 (case3 에서 빠르게 skip)
            startingIndex = bucketIndex;
            break;
          }
        }
      }
    }
  }
  return barDataBucketsBundle;
}

//--------------------------------------------------------------------------------
// 앱에서 선택한 GraphDataType 에 적합한 data 를 현재의 muscleContent 에서 가져오는 메소드
//--------------------------------------------------------------------------------
List<List<double>?> getDataValueList(GraphDataType dataType) {
  List<List<double>?> valueListBundle =
      []; // 그래프 표시 데이터 타입에 따라 한 그래프에 여러개의 선을 그릴 수 있어서 List 를 추가
  DbMuscleContents muscleContent = gv.dbMuscleContents; // 현재 근육 데이터
  bool isDataEmpty = muscleContent.dateStats.isEmpty;

  switch (dataType) {
    case GraphDataType.mvc:
      valueListBundle.add(isDataEmpty ? null : muscleContent.mvcMvMaxStats);
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.measuredMvcMvAccStats
              .mapIndexed((index, element) =>
                  element / (muscleContent.recordNumStats[index]))
              .toList());

      if (gv.setting.isGuideTypeTime.value != true) {
        valueListBundle.add(isDataEmpty
            ? null
            : muscleContent.emgCountAvAccStats
                .mapIndexed((index, element) =>
                    element / (muscleContent.recordNumStats[index]))
                .toList());
      } else {
        valueListBundle.add(isDataEmpty
            ? null
            : muscleContent.emgTimeAvAccStats
                .mapIndexed((index, element) =>
                    element / (muscleContent.recordNumStats[index]))
                .toList());
      }
      break;
    case GraphDataType.exerciseTimeAcc:
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.exerciseTimeAccStats
              .map((e) => e.toDouble())
              .toList());
      break;
    case GraphDataType.aoeSet:
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.aoeSetAccStats
              .mapIndexed((index, element) =>
                  element )
              .toList());
    //   break;
    // case GraphDataType.aoeTarget:
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.aoeTargetAccStats
              .mapIndexed((index, element) =>
                  element)
              .toList());

      break;
    case GraphDataType.frequency:
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.freqBeginAccStats
              .mapIndexed((index, element) =>
                  element / (muscleContent.recordNumStats[index]))
              .toList());
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.freqEndAccStats
              .mapIndexed((index, element) =>
                  element / (muscleContent.recordNumStats[index]))
              .toList());
      break;
    case GraphDataType.repetitionAvg:
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.repetitionAccStats
              .mapIndexed((index, element) =>
                  element / (muscleContent.recordNumStats[index]))
              .toList());
      // break;
    // case GraphDataType.repetitionTargetAvg:
      valueListBundle.add(isDataEmpty
          ? null
          : muscleContent.repetitionTargetAccStats
              .mapIndexed((index, element) =>
                  element / (muscleContent.recordNumStats[index]))
              .toList());
      break;
    default:
      break;
  }

  return valueListBundle;
}

//------------------------------------------------------------------------------
// barDataBucket 각각의 value(그래프의 yData 로 사용되는 값) 계산 메소드
//------------------------------------------------------------------------------
calculateYData(
    GraphDataType dataType, BarDataBucket barDataBucket, double value) {
  switch (dataType) {
    case GraphDataType.mvc:
      barDataBucket.sumOfValue =
          barDataBucket.sumOfValue + value * ( gv.setting.isViewUnitKgf.value == false ? 1 : GvDef.convLv);
      barDataBucket.maxValue =
          barDataBucket.maxValue < value ? value : barDataBucket.maxValue;
      barDataBucket.avgValue = barDataBucket.sumOfValue /
          (barDataBucket.indexListInDb.length + 1); // 평균을 구하기 위해 sumOfValue 를 버킷에 입력된 DB data 갯수로 나눠줌
      break;
    case GraphDataType.exerciseTimeAcc:
    case GraphDataType.aoeSet:
    // case GraphDataType.aoeTarget:
    case GraphDataType.frequency:
    case GraphDataType.repetitionAvg:
    // case GraphDataType.repetitionTargetAvg:
      barDataBucket.sumOfValue = barDataBucket.sumOfValue + value;
      barDataBucket.avgValue = barDataBucket.sumOfValue /
          (barDataBucket.indexListInDb.length + 1); // 평균을 구하기 위해 sumOfValue 를 버킷에 입력된 DB data 갯수로 나눠줌
      break;
    default:
      break;
  }
}

//------------------------------------------------------------------------------
// 완성된 barDataBuckets 으로 GraphData 생성하는 메소드
//------------------------------------------------------------------------------
GraphData makeGraphData(
    {required GraphTimePeriod timePeriod,
    required List<List<BarDataBucket>> bundleOfBarDataBuckets}) {
  GraphData graphData = GraphData(); // graphData 초기화

  //---------------------
  // xLabel 생성
  //---------------------
  graphData.xLabelList = makeXLabelList(
      timePeriod: timePeriod,
      barDataBuckets:
          bundleOfBarDataBuckets[0]); // 그래프 하나에 여러 선을 그리더라도 x 축의 label(날짜)은 같음

  //--------------------
  // yData 생성
  //---------------------
  graphData.yDataListBundle = [];
  for (int bundleIndex = 0;
      bundleIndex < bundleOfBarDataBuckets.length;
      bundleIndex++) {
    graphData.yDataListBundle.add(List.generate(
        bundleOfBarDataBuckets[bundleIndex].length,
        (index) => bundleOfBarDataBuckets[bundleIndex][index].avgValue));

    // dev.log('df_record.dart :: gv.dbMuscleContents.recordNumStats = ${gv.dbMuscleContents.recordNumStats}');
    // dev.log('df_record.dart :: graphData.yDataList = ${graphData.yDataList}');
  }

  // 생성된 X축 라벨과 yData 의 길이가 같은지 확인
  assert(graphData.xLabelList.length == graphData.yDataListBundle[0].length,
      'graphData.xLabelList.length != graphData.yDataList.length');

  //------------------------------------
  // visibleMaximum, visibleMinimum 생성
  //------------------------------------
  List<double> visibleRange = resetVisibleRange(
      timePeriod: gvRecord.graphTimePeriod.value,
      dataLength: graphData.yDataListBundle[0].length - 1);
  graphData.visibleMinimum = visibleRange[0];
  graphData.visibleMaximum = visibleRange[1];
  gvRecord.visibleMinIndex = graphData.visibleMinimum.ceil();
  gvRecord.visibleMaxIndex = graphData.visibleMaximum.toInt();
  return graphData;
}

//------------------------------------------------------------------------------
//GraphData 에 입력할 xLabel 을  생성하는 메소드
//------------------------------------------------------------------------------
// '년월일' 을 다 집어 넣고 graph xAxis label 울 rendering 할 때 labelFormatter 에서 처리
List<String> makeXLabelList(
    {required GraphTimePeriod timePeriod,
    required List<BarDataBucket> barDataBuckets}) {
  List<String> xLabelList = <String>[];
  String xLabel = ''; // label text 저장 변수
  //------------------------------------
  // bar data 1개가 1일을 나타낼 때
  //------------------------------------
  if (timePeriod == GraphTimePeriod.aWeek ||
      timePeriod == GraphTimePeriod.aMonth) {
    for (int index = 0; index < barDataBuckets.length; index++) {
      xLabelList.add(barDataBuckets[index].startDate.toString());
    }
  }
  //------------------------------------
  //bar data 1개가 1주일을 나타낼때
  //------------------------------------
  else if (timePeriod == GraphTimePeriod.threeMonths ||
      timePeriod == GraphTimePeriod.sixMonths) {
    for (int index = 0; index < barDataBuckets.length; index++) {
      xLabel =
          '${barDataBuckets[index].endDate.toString()}.${barDataBuckets[index].weekNum}'; // bar 1개가 1주일 때는 해당달의 몇번째 주 인지도 추가 (yyyyMMdd.X 형식)
      xLabelList.add(xLabel);
    }
  }
  //------------------------------------
  // bar data 1개가 1달일 때
  //------------------------------------
  else if (timePeriod == GraphTimePeriod.aYear) {
    for (int index = 0; index < barDataBuckets.length; index++) {
      xLabel = barDataBuckets[index].startDate.toString();
      xLabelList.add(xLabel);
    }
  }
  //-----------------------------------
  // 그밖의 TimePeriod 일 때 (발생할 일 없음)
  //-----------------------------------
  else {
    if (kDebugMode) {
      print('df_record.dart :: not available enum type');
    }
    xLabelList = ['Not Available TimePeriod'];
  }
  return xLabelList;
}

//----------------------------------------------------------------------------
// 처음 그려지는 그래프에 보여지는(표시되는) data 의 시작값과 마지막값의 index (즉, 처음 그래프에 보여지는 data 구간)
//----------------------------------------------------------------------------
List<double> resetVisibleRange(
    {required GraphTimePeriod timePeriod, required int dataLength}) {
  List<double> visible; // 처음 그래프를 화면에 그릴때 사용하는 data 의 min index, max index 값

  //------------------------------------
  // 1주 보기(1개의 data 는 1일 이라고 가정)
  //------------------------------------
  if (timePeriod == GraphTimePeriod.aWeek) {
    visible = [
      (dataLength - visibleDataNumber['aWeek']! + 1).toDouble(),
      dataLength.toDouble()
    ];
  }
  //------------------------------------
  // 1개월 보기 (1개의 data 는 1일 이라고 가정)
  //------------------------------------
  else if (timePeriod == GraphTimePeriod.aMonth) {
    visible = [
      (dataLength - visibleDataNumber['aMonth']! + 1).toDouble(),
      dataLength.toDouble()
    ];
  }

  //------------------------------------
  // 3개월 보기 (1개의 data 는 1주 라고 가정)
  //------------------------------------
  else if (timePeriod == GraphTimePeriod.threeMonths) {
    visible = [
      (dataLength - visibleDataNumber['threeMonths']! + 1).toDouble(),
      dataLength.toDouble()
    ];
  }

  //------------------------------------
  // 6개월 보기 (1개의 data 는 1주 라고 가정)
  //------------------------------------
  else if (timePeriod == GraphTimePeriod.sixMonths) {
    visible = [
      (dataLength - visibleDataNumber['sixMonths']! + 1).toDouble(),
      dataLength.toDouble()
    ];
  }
  //------------------------------------
  // 1년 보기 (1개의 data 는 1달 이라고 가정)
  //------------------------------------
  else if (timePeriod == GraphTimePeriod.aYear) {
    visible = [
      (dataLength - visibleDataNumber['aYear']! + 1).toDouble(),
      dataLength.toDouble()
    ];
  } else {
    if (kDebugMode) {
      print('df_record.dart :: not available enum type');
    }
    visible = [0, 0];
  }
  return visible;
}

//==============================================================================
// 기록 삭제에 따른 절차
//==============================================================================
deleteRecordData(int index) async {
  //----------------------------------------
  // dB에서 삭제
  await gv.dbmRecord.deleteData(index: index);
  //----------------------------------------
  // class 에서 삭제
  gv.dbRecordIndexes.removeAt(index);
  //----------------------------------------
  // 리스트 갱신
  gvRecord.totalNumOfRecord.value = gv.dbmRecord.numberOfData;
  RefreshRecordList.list();
  //----------------------------------------
  // 삭제 후 현재 근육관련 리스트 재 계산
  int count = 0;
  for (int n = 0; n < gvRecord.totalNumOfRecord.value; n++) {
    if (gv.dbRecordIndexes[n].idxMuscle == gv.control.idxMuscle.value) {
      count++;
    }
  }
  gv.control.numOfRecordPresentMuscle.value = count;
}

//==============================================================================
// deep copy
//==============================================================================
List<List<double>> deepCopy(List<List<double>> source) {
  return source.map((e) => e.toList()).toList();
}

//==============================================================================
// mvc 출력 형식 변환
//==============================================================================
String convertMvcToDisplayValue(double mvcValue,{int fractionDigits = 2, isViewUnit = true} ){
  String result = '';
  if(gv.setting.isViewUnitKgf.value == false) {
    result = mvcValue.toStringAsFixed(fractionDigits);
    if (isViewUnit){
      result = result + ' mV';
    }
  }
  else {
    int fractionDigitsForKgf = fractionDigits-1;
    if (fractionDigitsForKgf < 0 ) {
      fractionDigitsForKgf = 0;
    }
    result = (mvcValue*GvDef.convLv).toStringAsFixed(fractionDigitsForKgf);
    if (isViewUnit){
      result = result + ' kgf';
    }
  }
  return result;
}
