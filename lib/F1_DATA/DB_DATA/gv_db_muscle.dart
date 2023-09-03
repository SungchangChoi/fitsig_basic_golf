import '/F0_BASIC/common_import.dart';

part 'gv_db_muscle.g.dart';

// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs (출력 충돌날 때)
// 아래와 같은 에러 뜰 경우 pubspec.lock 지우고 다시 pub get 할 것
// type 'UnspecifiedInvalidResult' is not a subtype of type 'LibraryElementResult' in type cast

//==============================================================================
// 근육 DB (기본 4개 제공 후 추가되는 방식) - 최대 99개
//==============================================================================
// @JsonSerializable()
// class DbDataMuscle  {
//   DbDataMuscle();
//
//   int muscleId = 0;
//   String muscleName = '근육명';
//   int targetPrm = 70; //힘 목표 (0~100%)
//   int targetCount = 10; //목표 반복 횟수
//   double mvcLevel = 1.0; // 최대근력 1=1kg을 의미 (이두근 기준)
//
//   //----------------------------------------------------------------------------
//   // 통계 데이터
//   // MAX : 최대, ACC : 누적, 평균은 누적/기록 수
//   //----------------------------------------------------------------------------
//   List<int> dateStats = []; //20220725 8자리
//   List<int> recordNumStats = []; //해당 날짜 기록 수 (평균계산에 활용)
//   List<double> mvcLevelMaxStats = []; // 활용된 최대 근력 max (측정값 보다 크거나 같음)
//   List<double> measuredMvcLevelMaxStats = []; // 측정 된 최대근력 레벨
//   List<double> measuredMvcLevelAccStats = []; // 측정 된 최대근력 레벨 누적
//   List<int> exerciseTimeAccStats = []; //운동 시간 누적 (초)
//   List<double> aoeSetAccStats = []; //운동량 누적 - 세트 수
//   List<double> aoeTargetAccStats = []; //운동목표 누적
//   List<double> freqBeginAccStats = []; //시작 주파수 누적
//   List<double> freqEndAccStats = []; //종료 주파수 누적
//   List<double> emgCountMaxStats = []; // 근활성도 최대 값 - 카운트
//   List<double> emgCountAvAccStats = []; // 평균 근활성도 누적 - 카운트
//   List<double> emgTimeMaxStats = []; // 근활성도 최대 값 - 시간
//   List<double> emgTimeAvAccStats = []; // 평균 근활성도 누적 - 시간
//   List<int> repetitionAccStats = []; // 반복 누적 횟수
//   List<int> repetitionTargetAccStats = []; // 목표 달성 누적 횟수
//
//   //----------------------------------------------------------------------------
//   // json 자동 직렬화
//   // 변수가 변하면, 터미널 창에서 flutter pub run build_runner build
//   //----------------------------------------------------------------------------
//   factory DbDataMuscle.fromJson(Map<String, dynamic> json) =>
//       _$DbDataMuscleFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DbDataMuscleToJson(this);
// }

//==============================================================================
// 근육 DB - 기본적 index 정보 제공
//==============================================================================
@JsonSerializable()
class DbMuscleIndex {
  DbMuscleIndex();

  int muscleId = 0;
  String muscleName = '근육명';
  int targetPrm = 70; //힘 목표 (0~100%)
  int targetCount = 12; //목표 반복 횟수
  double mvcMv = 0.1; // mV, 표시할 때 level로 변환, 10배 하면 mvcLevel이 됨
  int muscleTypeIndex = 0;
  String imageFileName = '';

  // 상세 근육 index로 변경
  // 손목굽힘근부터 ~~~
  // 0 미선택, 1 팔, 2 어깨, 3 가슴, 4 복부, 5 등, 6 엉덩이, 7 다리
  bool isLeft = true; //근육의 좌우 여부

  //----------------------------------------------------------------------------
  // json 자동 직렬화
  // 변수가 변하면, 터미널 창에서 flutter pub run build_runner build
  //----------------------------------------------------------------------------
  // factory DbMuscleIndex.fromJson(Map<String, dynamic> json) =>
  //     _$DbMuscleIndexFromJson(json);
  //----------------------------------------------------------------------------
  // json 수동 직렬화
  //----------------------------------------------------------------------------
  DbMuscleIndex.fromJson(Map<String, dynamic> json)
      : muscleId = json['muscleId'] as int,
        muscleName = json['muscleName'] as String,
        targetPrm = json['targetPrm'] as int,
        targetCount = json['targetCount'] as int,
        mvcMv = (json['mvcMv'] as num).toDouble(),
        muscleTypeIndex = json['muscleTypeIndex'] as int,
        // 새로 추가한 변수는 null check
        isLeft = json['isLeft'] == null ? false : json['isLeft'] as bool,
        imageFileName = json['imageFileName'] == null
            ? ''
            : json['imageFileName'] as String;

  Map<String, dynamic> toJson() => _$DbMuscleIndexToJson(this);
}

//==============================================================================
// 근육 DB 상세 - 통계 데이터 기록
//==============================================================================
@JsonSerializable()
class DbMuscleContents {
  DbMuscleContents();

  //----------------------------------------------------------------------------
  // 통계 데이터
  // MAX : 최대, ACC : 누적, 평균은 누적/기록 수
  //----------------------------------------------------------------------------
  List<int> dateStats = []; //20220725 8자리
  List<int> recordNumStats = []; //해당 날짜 기록 수 (평균계산에 활용)
  List<double> mvcMvMaxStats = []; // 활용된 최대 근력전압 max (측정값 보다 크거나 같음)
  List<double> measuredMvcMvMaxStats = []; // 측정 된 최대근력 전압
  List<double> measuredMvcMvAccStats = []; // 측정 된 최대근력 전압 누적
  List<int> exerciseTimeAccStats = []; //운동 시간 누적 (초)
  List<double> aoeSetAccStats = []; //운동량 누적 - 세트 수
  List<double> aoeTargetAccStats = []; //운동목표 누적
  List<double> freqBeginAccStats = []; //시작 주파수 누적
  List<double> freqEndAccStats = []; //종료 주파수 누적
  List<double> emgCountMaxStats = []; // 근활성도 최대 값 - 카운트
  List<double> emgCountAvAccStats = []; // 평균 근활성도 누적 - 카운트
  List<double> emgTimeMaxStats = []; // 근활성도 최대 값 - 시간
  List<double> emgTimeAvAccStats = []; // 평균 근활성도 누적 - 시간
  List<int> repetitionAccStats = []; // 반복 누적 횟수
  List<int> repetitionTargetAccStats = []; // 목표 달성 누적 횟수

  //----------------------------------------------------------------------------
  // json 자동 직렬화
  // 변수가 변하면, 터미널 창에서 flutter pub run build_runner build
  //----------------------------------------------------------------------------
  factory DbMuscleContents.fromJson(Map<String, dynamic> json) =>
      _$DbMuscleContentsFromJson(json);

  Map<String, dynamic> toJson() => _$DbMuscleContentsToJson(this);

  bool removeContents(int date) {
    int dateIndex = 0;
    if (dateStats.contains(date)) {
      dateIndex = dateStats.indexOf(date);
      dateStats.removeAt(dateIndex);
      recordNumStats.removeAt(dateIndex);
      mvcMvMaxStats.removeAt(dateIndex);
      measuredMvcMvMaxStats.removeAt(dateIndex);
      measuredMvcMvAccStats.removeAt(dateIndex);
      exerciseTimeAccStats.removeAt(dateIndex);
      aoeSetAccStats.removeAt(dateIndex);
      aoeTargetAccStats.removeAt(dateIndex);
      freqBeginAccStats.removeAt(dateIndex);
      freqEndAccStats.removeAt(dateIndex);
      emgCountMaxStats.removeAt(dateIndex);
      emgCountAvAccStats.removeAt(dateIndex);
      emgTimeMaxStats.removeAt(dateIndex);
      emgTimeAvAccStats.removeAt(dateIndex);
      repetitionAccStats.removeAt(dateIndex);
      repetitionTargetAccStats.removeAt(dateIndex);
      return true;
    }
    return false;
  }
}

//==============================================================================
// map 데이터를 class 데이터로 변환 (처리 편리 목적)
//==============================================================================
void indexMapToMuscleIndexObject(int index) {
  if (gv.dbmMuscle.indexData.isNotEmpty) {
    gv.dbMuscleIndexes[index] =
        DbMuscleIndex.fromJson(gv.dbmMuscle.indexData[index]);
  }
}

void contentsMapToMuscleContentsObject() {
  if (gv.dbmMuscle.contentsData.isNotEmpty) {
    gv.dbMuscleContents = DbMuscleContents.fromJson(gv.dbmMuscle.contentsData);
  }
}

//==============================================================================
// 통계 데이터 저장
// set 단위 누적 저장 (?)이 맞는 듯 함
// 운동을 살살 한 예비 세트가 미치는 영향은?
// 통계를 어떻게 저장할지에 대한 고민 필요 (예비세트 무시 기능?)
// basic 에서는 기록단위 (=set 운동 기록)로 모두 저장 (세트 구분이 없으므로)
//==============================================================================
void saveReportStats(
    {required int idxMuscle,
    required DbRecordIndex iData,
    required DbRecordContents cData}) {
  int d = 0;
  var stats = gv.dbMuscleContents;
  int dateToday = todayInt8(); //오늘 날짜를 8자리로 표시
  //----------------------------------------------------------------------------
  // 통계 기록이 있다면
  //----------------------------------------------------------------------------
  if (stats.dateStats.isNotEmpty) {
    //--------------------------------------------------------------------------
    // 오늘날짜로 기록된 것이 있다면
    //--------------------------------------------------------------------------
    if (stats.dateStats.last == dateToday) {
      stats.recordNumStats.last += 1; //기록 수 증가 (평균 계산에 활용)

      //----------------------------------------
      // 활용 된 최대근력 - 그래프 표시 값
      stats.mvcMvMaxStats.last = max(stats.mvcMvMaxStats.last, iData.mvcMv);
      //----------------------------------------
      // 측정 된 최대근력 최대 및 평균 (기존의 기록보다 작을 수 있음)
      // 통계 그래프에 표시될 수 있음
      stats.measuredMvcMvMaxStats.last =
          max(stats.mvcMvMaxStats.last, cData.measureMvcMv); //측저된 최대근력 레벨 최대값
      stats.measuredMvcMvAccStats.last += cData.measureMvcMv; //최대근력 레벨 누적
      //----------------------------------------
      // 운동시간 및 운동량
      stats.exerciseTimeAccStats.last += iData.exerciseTime; //운동 시간 누적 (초)
      stats.aoeSetAccStats.last += iData.aoeSet; //운동량 누적 - 세트 수
      stats.aoeTargetAccStats.last += cData.aoeTarget; //운동목표 누적
      //----------------------------------------
      // 주파수
      stats.freqBeginAccStats.last += cData.freqBegin; //시작 주파수 누적
      stats.freqEndAccStats.last += cData.freqEnd; //종료 주파수 누적
      //----------------------------------------
      // 근활성도
      stats.emgCountMaxStats.last = max(
          stats.emgCountMaxStats.last, cData.emgCountMax); // 근활성도 최대 값 - 카운트
      stats.emgCountAvAccStats.last += cData.emgCountAv; // 평균 근활성도 누적 - 카운트
      stats.emgTimeMaxStats.last =
          max(stats.emgTimeMaxStats.last, cData.emgTimeMax); // 근활성도 최대 값 - 시간
      stats.emgTimeAvAccStats.last += cData.emgTimeAv; // 평균 근활성도 누적 - 시간
      //----------------------------------------
      // 반복횟수
      stats.repetitionAccStats.last += cData.repetition; // 반복 누적 횟수
      stats.repetitionTargetAccStats.last +=
          cData.repetitionTargetSuccess; // 목표 달성 누적 횟수
    }
    //--------------------------------------------------------------------------
    // 오늘날짜로 기록된 것이 없다면
    //--------------------------------------------------------------------------
    else {
      //오늘 날짜로 신규 데이터 추가
      addNewReportStats(idxMuscle: idxMuscle, iData: iData, cData: cData);
    }
  }
  //----------------------------------------------------------------------------
  // 완전 처음이라면
  //----------------------------------------------------------------------------
  else if (stats.dateStats.isEmpty) {
    //오늘 날짜로 신규 데이터 추가
    addNewReportStats(idxMuscle: idxMuscle, iData: iData, cData: cData);
  }
}

//==============================================================================
// 오늘 날짜로 신규 데이터 추가
// 데이터를 1개씩 추가
//==============================================================================
void addNewReportStats(
    {required int idxMuscle,
    required DbRecordIndex iData,
    required DbRecordContents cData}) {
  var stats = gv.dbMuscleContents;
  int dateToday = todayInt8();

  // 오늘 날짜로 통계 데이터 더하기
  stats.dateStats.add(dateToday);
  stats.recordNumStats.add(1); //해당 날짜 기록 수 (평균계산에 활용)

  //--------------- 최대근력
  stats.mvcMvMaxStats.add(iData.mvcMv.toPrecision(2)); //최대근력 레벨
  stats.measuredMvcMvMaxStats.add(cData.measureMvcMv.toPrecision(2)); //최대근력 레벨
  stats.measuredMvcMvAccStats
      .add(cData.measureMvcMv.toPrecision(2)); //최대근력 레벨 누적
  //--------------- 운동시간 및 운동량
  stats.exerciseTimeAccStats.add(iData.exerciseTime); //운동 시간 누적 (초)
  stats.aoeSetAccStats.add(iData.aoeSet.toPrecision(2)); //운동량 누적 - 세트 수
  stats.aoeTargetAccStats.add(cData.aoeTarget.toPrecision(2)); //운동목표 누적
  //--------------- 주파수
  stats.freqBeginAccStats.add(cData.freqBegin.toPrecision(2)); //시작 주파수 누적
  stats.freqEndAccStats.add(cData.freqEnd.toPrecision(2)); //종료 주파수 누적
  //--------------- 근활성도
  stats.emgCountMaxStats
      .add(cData.emgCountMax.toPrecision(2)); // 근활성도 최대 값 - 카운트
  stats.emgCountAvAccStats
      .add(cData.emgCountAv.toPrecision(2)); // 평균 근활성도 누적 - 카운트
  stats.emgTimeMaxStats.add(cData.emgTimeMax.toPrecision(2)); // 근활성도 최대 값 - 시간
  stats.emgTimeAvAccStats
      .add(cData.emgTimeAv.toPrecision(2)); // 평균 근활성도 누적 - 시간
  //--------------- 반복횟수
  stats.repetitionAccStats.add(cData.repetition); // 반복 누적 횟수
  stats.repetitionTargetAccStats
      .add(cData.repetitionTargetSuccess); // 목표 달성 누적 횟수
}
