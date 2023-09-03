// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gv_db_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DbRecordIndex _$DbRecordIndexFromJson(Map<String, dynamic> json) =>
    DbRecordIndex()
      ..startTime = DateTime.parse(json['startTime'] as String)
      ..endTime = DateTime.parse(json['endTime'] as String)
      ..exerciseTime = json['exerciseTime'] as int
      ..idxMuscle = json['idxMuscle'] as int
      ..muscleName = json['muscleName'] as String
      ..muscleTypeIndex = json['muscleTypeIndex'] as int
      ..isLeft = json['isLeft'] as bool
      ..targetPrm = json['targetPrm'] as int
      ..targetCount = json['targetCount'] as int
      ..mvcMv = (json['mvcMv'] as num).toDouble()
      ..aoeSet = (json['aoeSet'] as num).toDouble()
      ..greatestEverMvcMv = (json['greatestEverMvcMv'] as num).toDouble()
      ..isEcgEmpty = json['isEcgEmpty'] as bool;

Map<String, dynamic> _$DbRecordIndexToJson(DbRecordIndex instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'exerciseTime': instance.exerciseTime,
      'idxMuscle': instance.idxMuscle,
      'muscleName': instance.muscleName,
      'muscleTypeIndex': instance.muscleTypeIndex,
      'isLeft': instance.isLeft,
      'targetPrm': instance.targetPrm,
      'targetCount': instance.targetCount,
      'mvcMv': instance.mvcMv,
      'aoeSet': instance.aoeSet,
      'greatestEverMvcMv': instance.greatestEverMvcMv,
      'isEcgEmpty': instance.isEcgEmpty,
    };

DbRecordContents _$DbRecordContentsFromJson(Map<String, dynamic> json) =>
    DbRecordContents()
      ..measureMvcMv = (json['measureMvcMv'] as num).toDouble()
      ..emgTimeMax = (json['emgTimeMax'] as num).toDouble()
      ..emgTimeAv = (json['emgTimeAv'] as num).toDouble()
      ..emgCountMax = (json['emgCountMax'] as num).toDouble()
      ..emgCountAv = (json['emgCountAv'] as num).toDouble()
      ..aoeTarget = (json['aoeTarget'] as num).toDouble()
      ..repetition = json['repetition'] as int
      ..repetitionTargetSuccess = json['repetitionTargetSuccess'] as int
      ..freqBegin = (json['freqBegin'] as num).toDouble()
      ..freqEnd = (json['freqEnd'] as num).toDouble()
      ..emgData = (json['emgData'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..emgTime = (json['emgTime'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..markTime = (json['markTime'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..markValue = (json['markValue'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..targetResult = (json['targetResult'] as List<dynamic>)
          .map((e) => $enumDecode(_$EmlTargetResultEnumMap, e))
          .toList()
      ..electrodeContactData = (json['electrodeContactData'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..isExBufferCleared = (json['isExBufferCleared'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..endTime = (json['endTime'] as num).toDouble()
      ..electrodeContactMax = (json['electrodeContactMax'] as num).toDouble()
      ..exCntDetach = json['exCntDetach'] as int
      ..exTimeDetached = (json['exTimeDetached'] as num).toDouble()
      ..exCntExternal = json['exCntExternal'] as int
      ..exTimeFake = (json['exTimeFake'] as num).toDouble()
      ..ecgData = (json['ecgData'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..ecgCountTime = (json['ecgCountTime'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..ecgHeartRateMax = (json['ecgHeartRateMax'] as num).toDouble()
      ..ecgHeartRateMin = (json['ecgHeartRateMin'] as num).toDouble()
      ..ecgHeartRateAv = (json['ecgHeartRateAv'] as num).toDouble();

Map<String, dynamic> _$DbRecordContentsToJson(DbRecordContents instance) =>
    <String, dynamic>{
      'measureMvcMv': instance.measureMvcMv,
      'emgTimeMax': instance.emgTimeMax,
      'emgTimeAv': instance.emgTimeAv,
      'emgCountMax': instance.emgCountMax,
      'emgCountAv': instance.emgCountAv,
      'aoeTarget': instance.aoeTarget,
      'repetition': instance.repetition,
      'repetitionTargetSuccess': instance.repetitionTargetSuccess,
      'freqBegin': instance.freqBegin,
      'freqEnd': instance.freqEnd,
      'emgData': instance.emgData,
      'emgTime': instance.emgTime,
      'markTime': instance.markTime,
      'markValue': instance.markValue,
      'targetResult': instance.targetResult
          .map((e) => _$EmlTargetResultEnumMap[e]!)
          .toList(),
      'electrodeContactData': instance.electrodeContactData,
      'isExBufferCleared': instance.isExBufferCleared,
      'endTime': instance.endTime,
      'electrodeContactMax': instance.electrodeContactMax,
      'exCntDetach': instance.exCntDetach,
      'exTimeDetached': instance.exTimeDetached,
      'exCntExternal': instance.exCntExternal,
      'exTimeFake': instance.exTimeFake,
      'ecgData': instance.ecgData,
      'ecgCountTime': instance.ecgCountTime,
      'ecgHeartRateMax': instance.ecgHeartRateMax,
      'ecgHeartRateMin': instance.ecgHeartRateMin,
      'ecgHeartRateAv': instance.ecgHeartRateAv,
    };

const _$EmlTargetResultEnumMap = {
  EmlTargetResult.none: 'none',
  EmlTargetResult.high: 'high',
  EmlTargetResult.low: 'low',
  EmlTargetResult.success: 'success',
  EmlTargetResult.perfect: 'perfect',
};
