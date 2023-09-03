import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//==============================================================================
// record 관련 전역변수
//==============================================================================
GvRecord gvRecord = GvRecord();

// 그래프 보기 기간(타입)
enum GraphTimePeriod {
  aWeek,
  aMonth,
  threeMonths,
  sixMonths,
  aYear
} // 1주, 1달, 3달, 6달, 1년


// 그래프 표시 데이터(타입)
enum GraphDataType {
  mvc,        // 0 : 근력
  exerciseTimeAcc, // 1 : 운동시간
  aoeSet,             // 2 : 운동량(세트)
  // aoeTarget,             // 3 : 운동량(목표)
  frequency,       // 4 : 근전도 주파수
  repetitionAvg,   // 5 : 평균 반복수
  // repetitionTargetAvg, // 6  : 평균 반복수(목표)
}
//     {
//   mvcLevelMax,     // 0
//   measuredMvcLevelMax,
//   measuredMvcLevelAvg,  // 2
//   exerciseTimeAcc,
//   aoeSetAvg,  // 4
//   aoeTargetAvg,
//   freqBeginAvg, // 6
//   freqEndAvg,
//   freqDiffAvg,  // 8
//   emgCountMax,
//   emgCountMaxPercent,  // 10
//   emgCountAvAvg,
//   emgCountAvAvgPercent, // 12
//   emgTimeMax,
//   emgTimeMaxPercent,  // 14
//   emgTimeAvAvg,
//   emgTimeAvAvgPercent, // 16
//   repetitionAvg,
//   repetitionTargetAvg, // 18
// } // 최대근력, 운동량, 운동시간...

// 반복운동에서 표시할 GraphDataType index
// List<int> graphDataTypeIndexForRepetition = [0, 1, 2, 3, 4, 5, 6];
List<int> graphDataTypeIndexForTime = [0, 1, 2, 3, 4];

// 통계 그래프를 보여주는 UI 에서 dataType 선택에 따라 화면에 표시되는 text
// 엑셀 파일 만들때 첫번째 row 에 항목을 입력할 때 사용하는 리스트
List<String> graphDataTypeDisplayText =
[
  '날짜',           // 0
  '해당날짜 기록수',  // 1
  '근력',           // 2
  '운동시간',        // 3
  '운동량',          // 4
  '근주파수', // 5
  '평균 반복수',      // 6
];
List<String> excelColumnItemText =
[
  '날짜',           // 0
  '해당날짜 기록수',  // 1
  '최대근력\n(기준)', // 2
  '최대근력\n(측정)', // 3
  '평균근력\n(측정)', // 4
  '운동시간',        // 5
  '운동량\n(1세트)', // 6
  '운동량\n(목표)',  // 7
  '주파수\n(시작)',   // 8
  '주파수\n(종료)',  // 9
  '주파수\n차이',    // 10
  '근활성도\n(최대,횟수)', // 11
  '근활성도 비율\n(최대,횟수)', // 12
  '근활성도\n(평균,횟수)',     // 13
  '근활성도 비율\n(평균,횟수)', // 14
  '근활성도\n(최대,시간)',     // 15
  '근활성도 비율\n(최대,시간)', // 16
  '근활성도\n(평균,시간)',     // 17
  '근활성도 비율\n(평균,시간)', // 18
  '평균 반복수',              // 19
  '평균 반복수\n(목표)',      // 20
];

//그래프 보기 기간(타입)에 따른, 그래프 화면에 보이는 데이터 수( 스크롤해야 보이는 것 말고, 딱 바로 보이는 데이터 수)
Map<String, int> visibleDataNumber = {
  'aWeek': 7, //  단위: 일. 그래프 화면 bar 표시 수 (bar 1개 1일)
  'aMonth': 30, //  단위: 일. 그래프 화면 bar 표시 수 (bar 1개 1일)
  'threeMonths': 15, //  단위: 주. 그래프 화면 bar 표시 수 (bar 1개 1주일)
  'sixMonths': 30, //  단위: 주. 그래프 화면 bar 표시 수 (bar 1개 1주일)
  'aYear': 12, //  단위: 월. 그래프 화면 bar 표시 수 (bar 1개 1달)
};

class GvRecord {
  //----------------------------------------------------------------------------
  // 버튼 제어변수
  //----------------------------------------------------------------------------
  RxBool isSelectedStatsView = true.obs; //그래프 보기, 리스트 보기
  RxBool isViewListSimple = false.obs; //리스트 간략보기, 자세히 보기
  Rx<GraphTimePeriod> graphTimePeriod =
      GraphTimePeriod.aMonth.obs; // 그래프로 보기 기간(1주, 1달, 3달, 6달, 1년)
  Rx<GraphDataType> graphDataType =
      GraphDataType.mvc.obs; // 그패르 표시 데이터 타입 (최대근력, 운동량, ....)
  RxBool isTrendLineOn = false.obs; // 통계 그래프에서 추세선 보기
  RxBool isToGoEnd = false.obs; //맨 끝으로


  //----------------------------------------------------------------------------
  // 데이터 처리 변수
  //----------------------------------------------------------------------------
  RxInt totalNumOfRecord = 0.obs; //기록 항목 수

  //----------------------------------------------------------------------------
  // 삭제할 데이터 기준 날짜 저장 변수
  //----------------------------------------------------------------------------
  RxInt yearOfDeleteRecord =
      (int.parse(DateFormat('yyyy').format(DateTime.now()))).obs;
  RxInt monthOfDeleteRecord =
      (int.parse(DateFormat('MM').format(DateTime.now()))).obs;
  RxInt dayOfDeleteRecord =
      (int.parse(DateFormat('dd').format(DateTime.now()))).obs;

  //----------------------------------------------------------------------------
  // 그래프 제어 변수 및 그래프 데이터 (상태) 저장 변수
  //----------------------------------------------------------------------------
  bool isViewEcg = false; //심전도 파형 보기
  RxBool isSelectedViewPrm = true.obs; //%1RM 보기
  RxBool isSelectedViewMark = false.obs; //%마크 보기
  int visibleMinIndex = 0; // 그래프에 보여지는 data 의 구간의 최소(?) index 값
  int visibleMaxIndex = 0; // 그래프에 보여지는 data 의 구간의 최대(?) index 값
  RxInt graphDataUpdateCount = 0.obs; // 그래프 data 가 update 되면 변화 되는 값
  RxInt graphTimeRangeUpdateCount = 0.obs; // 그래프에 보여지는 기간 변경시 변화되는 값
  List<BarDataBucket> barDataBuckets = <
      BarDataBucket>[]; // df_record.dart 파일의 makeBarDataBuckets( ) 메소드 실행 결과 저장용
  GraphData graphData =
      GraphData(); // df_record.dart 파일의 makeGraphData( ) 메소드 실행 결과 저장용.

  // double trendLineSlope = 0.0;
  // double trendLineYIntercept = 0.0;
  // int firstIndexOnChartWindow = 0; // 현재 보여지는 화면에서 data 가 존재하는 첫번째 index
  // int lastIndexOnChartWindow = 0; // 현재 보여지는 화면에서 data 가 존재하는 마지막 index
  ChartSeriesController? trendLineController;
  List<List<double>> trendLinePointList = <List<double>>[];
  RxInt trendLineUpdateCount = 0.obs; // 그래프에 보여지는 기간 변경시 변화되는 값



  //----------------------------------------------------------------------------
  // 앱을 시작할 때 graph data 값을 준비해 놓기 위한 메소드 (app_init.dart 의 마지막에 실행)
  //----------------------------------------------------------------------------
  void init() {
    updateGraphData(timePeriod: GraphTimePeriod.aWeek);
  }
}
