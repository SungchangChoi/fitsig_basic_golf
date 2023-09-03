// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gv_db_muscle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DbMuscleIndex _$DbMuscleIndexFromJson(Map<String, dynamic> json) =>
    DbMuscleIndex()
      ..muscleId = json['muscleId'] as int
      ..muscleName = json['muscleName'] as String
      ..targetPrm = json['targetPrm'] as int
      ..targetCount = json['targetCount'] as int
      ..mvcMv = (json['mvcMv'] as num).toDouble()
      ..muscleTypeIndex = json['muscleTypeIndex'] as int
      ..imageFileName = json['imageFileName'] as String
      ..isLeft = json['isLeft'] as bool;

Map<String, dynamic> _$DbMuscleIndexToJson(DbMuscleIndex instance) =>
    <String, dynamic>{
      'muscleId': instance.muscleId,
      'muscleName': instance.muscleName,
      'targetPrm': instance.targetPrm,
      'targetCount': instance.targetCount,
      'mvcMv': instance.mvcMv,
      'muscleTypeIndex': instance.muscleTypeIndex,
      'imageFileName': instance.imageFileName,
      'isLeft': instance.isLeft,
    };

DbMuscleContents _$DbMuscleContentsFromJson(Map<String, dynamic> json) =>
    DbMuscleContents()
      ..dateStats =
          (json['dateStats'] as List<dynamic>).map((e) => e as int).toList()
      ..recordNumStats = (json['recordNumStats'] as List<dynamic>)
          .map((e) => e as int)
          .toList()
      ..mvcMvMaxStats = (json['mvcMvMaxStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..measuredMvcMvMaxStats = (json['measuredMvcMvMaxStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..measuredMvcMvAccStats = (json['measuredMvcMvAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..exerciseTimeAccStats = (json['exerciseTimeAccStats'] as List<dynamic>)
          .map((e) => e as int)
          .toList()
      ..aoeSetAccStats = (json['aoeSetAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..aoeTargetAccStats = (json['aoeTargetAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..freqBeginAccStats = (json['freqBeginAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..freqEndAccStats = (json['freqEndAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..emgCountMaxStats = (json['emgCountMaxStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..emgCountAvAccStats = (json['emgCountAvAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..emgTimeMaxStats = (json['emgTimeMaxStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..emgTimeAvAccStats = (json['emgTimeAvAccStats'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()
      ..repetitionAccStats = (json['repetitionAccStats'] as List<dynamic>)
          .map((e) => e as int)
          .toList()
      ..repetitionTargetAccStats =
          (json['repetitionTargetAccStats'] as List<dynamic>)
              .map((e) => e as int)
              .toList();

Map<String, dynamic> _$DbMuscleContentsToJson(DbMuscleContents instance) =>
    <String, dynamic>{
      'dateStats': instance.dateStats,
      'recordNumStats': instance.recordNumStats,
      'mvcMvMaxStats': instance.mvcMvMaxStats,
      'measuredMvcMvMaxStats': instance.measuredMvcMvMaxStats,
      'measuredMvcMvAccStats': instance.measuredMvcMvAccStats,
      'exerciseTimeAccStats': instance.exerciseTimeAccStats,
      'aoeSetAccStats': instance.aoeSetAccStats,
      'aoeTargetAccStats': instance.aoeTargetAccStats,
      'freqBeginAccStats': instance.freqBeginAccStats,
      'freqEndAccStats': instance.freqEndAccStats,
      'emgCountMaxStats': instance.emgCountMaxStats,
      'emgCountAvAccStats': instance.emgCountAvAccStats,
      'emgTimeMaxStats': instance.emgTimeMaxStats,
      'emgTimeAvAccStats': instance.emgTimeAvAccStats,
      'repetitionAccStats': instance.repetitionAccStats,
      'repetitionTargetAccStats': instance.repetitionTargetAccStats,
    };
