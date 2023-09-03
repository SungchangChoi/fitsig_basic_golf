import '/F0_BASIC/common_import.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


// Class 수정시 flutter pub run build_runner build 실행해서 gv_hive_muscle.g.dart 실행

//==============================================================================
// 근육 DB (기본 4개 제공 후 추가되는 방식) - 최대 99개
//==============================================================================
// @HiveType(typeId: 0)
// class DbHiveDataMuscle extends HiveObject {
//   DbHiveDataMuscle();
//
//   @HiveField(0)
//   int muscleId = 0;
//   @HiveField(1)
//   String muscleName = '근육명';
//   @HiveField(2)
//   int targetPrm = 70; //힘 목표 (0~100%)
//   @HiveField(3)
//   int targetCount = 10; //목표 반복 횟수
//   @HiveField(4)
//   double mvcLevel = 1.0; // 최대근력 1=1kg을 의미 (이두근 기준)
//
//   //----------------------------------------------------------------------------
//   // 통계 데이터
//   // MAX : 최대, ACC : 누적, 평균은 누적/기록 수
//   //----------------------------------------------------------------------------
//   @HiveField(5)
//   List<int> dateStats = []; //20220725 8자리
//   @HiveField(6)
//   List<int> recordNumStats = []; //해당 날짜 기록 수 (평균계산에 활용)
//   @HiveField(7)
//   List<double> mvcLevelMaxStats = []; // 활용된 최대 근력 max (측정값 보다 크거나 같음)
//   @HiveField(8)
//   List<double> measuredMvcLevelMaxStats = []; // 측정 된 최대근력 레벨
//   @HiveField(9)
//   List<double> measuredMvcLevelAccStats = []; // 측정 된 최대근력 레벨 누적
//   @HiveField(10)
//   List<int> exerciseTimeAccStats = []; //운동 시간 누적 (초)
//   @HiveField(11)
//   List<double> aoeSetAccStats = []; //운동량 누적 - 세트 수
//   @HiveField(12)
//   List<double> aoeTargetAccStats = []; //운동목표 누적
//   @HiveField(13)
//   List<double> freqBeginAccStats = []; //시작 주파수 누적
//   @HiveField(14)
//   List<double> freqEndAccStats = []; //종료 주파수 누적
//   @HiveField(15)
//   List<double> emgCountMaxStats = []; // 근활성도 최대 값 - 카운트
//   @HiveField(16)
//   List<double> emgCountAvAccStats = []; // 평균 근활성도 누적 - 카운트
//   @HiveField(17)
//   List<double> emgTimeMaxStats = []; // 근활성도 최대 값 - 시간
//   @HiveField(18)
//   List<double> emgTimeAvAccStats = []; // 평균 근활성도 누적 - 시간
//   @HiveField(19)
//   List<int> repetitionAccStats = []; // 반복 누적 횟수
//   @HiveField(20)
//   List<int> repetitionTargetAccStats = []; // 목표 달성 누적 횟수
//
//   factory DbHiveDataMuscle.parseDbMuscle(DbDataMuscle data){
//      return DbHiveDataMuscle()
//       ..muscleId = data.muscleId
//          ..muscleName = data.muscleName
//          ..targetPrm = data.targetPrm
//          ..targetCount = data.targetCount
//          ..mvcLevel = data.mvcLevel
//          ..dateStats = data.dateStats
//          ..recordNumStats = data.recordNumStats
//          ..mvcLevelMaxStats = data.mvcLevelMaxStats
//          ..measuredMvcLevelMaxStats = data.measuredMvcLevelMaxStats
//          ..measuredMvcLevelAccStats = data.measuredMvcLevelAccStats
//          ..exerciseTimeAccStats = data.exerciseTimeAccStats
//          ..aoeSetAccStats = data.aoeSetAccStats
//          ..aoeTargetAccStats = data.aoeTargetAccStats
//          ..freqBeginAccStats = data.freqBeginAccStats
//          ..freqEndAccStats = data.freqEndAccStats
//          ..emgCountMaxStats = data.emgCountMaxStats
//          ..emgCountAvAccStats = data.emgCountAvAccStats
//          ..emgTimeMaxStats = data.emgTimeMaxStats
//          ..emgTimeAvAccStats = data.emgTimeAvAccStats
//          ..repetitionAccStats = data.repetitionAccStats
//          ..repetitionTargetAccStats = data.repetitionTargetAccStats;
//   }
// }
