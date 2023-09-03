import '/F0_BASIC/common_import.dart';

// part 'gv_db_statistics.g.dart';

// flutter pub run build_runner build
// 아래와 같은 에러 뜰 경우 pubspec.lock 지우고 다시 pub get 할 것
// type 'UnspecifiedInvalidResult' is not a subtype of type 'LibraryElementResult' in type cast
//
// //==============================================================================
// // 기록 데이터  내용 - json 직렬화 적용
// // double 의 경우 소숫점 자리 제한하여 직렬화 (데이터 저장용량 효율화 목적)
// // 근육이름, 힘 목표, 최대 근력, 운동시작일시, 운동종료 일시, 평균 근 활성도(반복, 게이지)
// // 최대 근활성도(반복, 게이지), 목표 달성, 1세트 운동량, 시작 주파수, 종료 주파수, 반복 횟수, 근전도 파형...
// //==============================================================================
// @JsonSerializable()
// class DbDataStatistics {
//   DbDataStatistics();
//
//   //----------------------------------------------------------------------------
//   // 기본 정보
//   //----------------------------------------------------------------------------
//   int muscleId = 0;
//   String muscleName = '근육이름';
//   //-------------------------- 각 항목의 시간 저장
//   // List<int> year = [];
//   // List<int> month = [];
//   // List<int> date = [];
//   // List<int> hour = [];
//   // List<int> min = [];
//   // List<int> sec = [];
//   List<int> date = []; //20220725 8자리
//   // List<DateTime> dateTime = [];
//   //----------------------------------------------------------------------------
//   // 통계 값
//   //----------------------------------------------------------------------------
//   List<double> mvcLevel = []; //최대근력 레벨
//   List<double> exerciseTime = []; //운동 시간
//   List<double> aoeSet = []; //운동량
//   List<double> aoeTarget = []; //운동목표
//   List<double> freqBegin = []; //시작 주파수
//   List<double> freqEnd = []; //종료 주파수
//   List<double> freqDiff = []; //종료 주파수
//   List<double> emgMax = []; // 근활성도 최대 값
//   List<double> emgMean = []; // 평균 근활성도
//   List<double> p1rmMax = []; // 근활성도 최대 값
//   List<double> p1rmMean = []; // 평균 근활성도
//
//
//   //----------------------------------------------------------------------------
//   // json 자동 직렬화
//   // 변수가 변하면, 터미널 창에서 flutter pub run build_runner build
//   //----------------------------------------------------------------------------
//   factory DbDataStatistics.fromJson(Map<String, dynamic> json) =>
//       _$DbDataStatisticsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DbDataStatisticsToJson(this);
// }
//
//
// //==============================================================================
// // map 데이터를 class 데이터로 변환 (처리 편리 목적)
// // 통계는 1개의 레코드만 존재
// //==============================================================================
// void mapToDbDataStatistics() {
//   if (gv.dbmStatistics.tData.isNotEmpty) {
//     gv.dataStatistics =
//         DbDataStatistics.fromJson(gv.dbmStatistics.tData[0]);
//   }
// }