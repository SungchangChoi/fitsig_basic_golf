import '/F0_BASIC/common_import.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

// Class 수정시 flutter pub run build_runner build 실행해서 db_hive_muscle.g.dart 실행

// part 'db_hive_data_record.g.dart';

//==============================================================================
// 기록 데이터  내용
// double 의 경우 소숫점 자리 제한하여 직렬화 (데이터 저장용량 효율화 목적)
// 근육이름, 힘 목표, 최대 근력, 운동시작일시, 운동종료 일시, 평균 근 활성도(반복, 게이지)
// 최대 근활성도(반복, 게이지), 목표 달성, 1세트 운동량, 시작 주파수, 종료 주파수, 반복 횟수, 근전도 파형...
//==============================================================================
// @HiveType(typeId: 1)
// @JsonSerializable(explicitToJson: true)
// class DbHiveDataRecord{//} extends HiveObject{
//   DbHiveDataRecord();
//   //----------------------------------------------------------------------------
//   // 기본 정보
//   //----------------------------------------------------------------------------
//   @HiveField(0)
//   int idxMuscle = 0;
//   @HiveField(1)
//   String muscleName = '근육이름';
//   @HiveField(2)
//   int targetPrm = 70; //힘 목표 (0~100%)
//   @HiveField(3)
//   int targetCount = 10; //목표 반복 횟수
//   @HiveField(4)
//   DateTime startTime = DateTime(2022);
//   @HiveField(5)
//   DateTime endTime = DateTime(2022);
//   @HiveField(6)
//   int exerciseTime = 0;
//
//   //----------------------------------------------------------------------------
//   // 분석 정보
//   //----------------------------------------------------------------------------
//   //------------------- 최대근력
//   @HiveField(7)
//   double mvcMv = 0.1; //현재의 최대근력 전압
//   @HiveField(8)
//   double measureMvcMv = 0.1; //측정된 최대근력 전압
//   //------------------- 근활성도
//   @HiveField(9)
//   double emgTimeMax = 0; //최대 근활성도 (시간 방식)
//   @HiveField(10)
//   double emgTimeAv = 0; //평균 근활성도 (시간 방식)
//   @HiveField(11)
//   double emgCountMax = 0; //최대 근활성도 (카운트 방식)
//   @HiveField(12)
//   double emgCountAv = 0; //평균 근활성도 (카운트 방식)
//   //------------------- 운동량
//   @HiveField(13)
//   double aoeSet = 0; //세트 운동량
//   @HiveField(14)
//   double aoeTarget = 0; //세트 목표 운동량
//   //------------------- 반복 횟수
//   @HiveField(15)
//   int repetition = 0; //측정된 반복횟수
//   @HiveField(16)
//   int repetitionTargetSuccess = 0; //목표 성공 횟수
//   //------------------- 주파수
//   @HiveField(17)
//   double freqBegin = 0;
//   @HiveField(18)
//   double freqEnd = 0;
//
//   //----------------------------------------------------------------------------
//   // 근전도 파형
//   //----------------------------------------------------------------------------
//   @HiveField(19)
//   List<double> emgData = []; //소수점 제한하여 직렬화 필요
//   @HiveField(20)
//   List<double> emgTime = []; //소수점 제한하여 직렬화 필요
//   @HiveField(21)
//   List<double> markTime = []; //마크 시간
//   @HiveField(22)
//   List<double> markValue = []; //마크 값
//
//   factory DbHiveDataRecord.formJson(Map<String, dynamic> json)=> _$DbHiveDataRecordFromJson(json);
//   Map<String, dynamic> toJson() => _$DbHiveDataRecordToJson(this);



  // factory DbHiveDataRecord.parseDbRecord(DbDataRecord data){
  //   return DbHiveDataRecord()
  //     ..idxMuscle = data.idxMuscle
  //     ..muscleName = data.muscleName
  //     ..targetPrm = data.targetPrm
  //     ..targetCount = data.targetCount
  //     ..startTime = data.startTime
  //     ..endTime = data.endTime
  //     ..exerciseTime = data.exerciseTime
  //     ..mvcMv = data.mvcMv
  //     ..measureMvcMv = data.measureMvcMv
  //     ..emgTimeMax = data.emgTimeMax
  //     ..emgTimeAv = data.emgTimeAv
  //     ..emgCountMax = data.emgCountMax
  //     ..emgCountAv = data.emgCountAv
  //     ..aoeSet = data.aoeSet
  //     ..aoeTarget = data.aoeTarget
  //     ..repetition = data.repetition
  //     ..repetitionTargetSuccess = data.repetitionTargetSuccess
  //     ..freqBegin = data.freqBegin
  //     ..freqEnd = data.freqEnd
  //     ..emgData = data.emgData
  //     ..emgTime = data.emgTime
  //     ..markTime = data.markTime
  //     ..markValue = data.markValue;
  // }
// }
