// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_vitals_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordVitalsCommandModel _$RecordVitalsCommandModelFromJson(
  Map<String, dynamic> json,
) => RecordVitalsCommandModel(
  admissionId: json['admissionId'] as String?,
  temperature: (json['temperature'] as num?)?.toDouble(),
  bP_Systolic: (json['bP_Systolic'] as num?)?.toInt(),
  bP_Diastolic: (json['bP_Diastolic'] as num?)?.toInt(),
  heartRate: (json['heartRate'] as num?)?.toInt(),
  respRate: (json['respRate'] as num?)?.toInt(),
  pulseOxy: (json['pulseOxy'] as num?)?.toInt(),
  supplementalOxygen: json['supplementalOxygen'] as bool?,
  consciousnessLevel: $enumDecodeNullable(
    _$ConsciousnessLevelEnumMap,
    json['consciousnessLevel'],
  ),
  recordedAt: json['recordedAt'] as String?,
  nurseId: json['nurseId'] as String?,
);

Map<String, dynamic> _$RecordVitalsCommandModelToJson(
  RecordVitalsCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'temperature': instance.temperature,
  'bP_Systolic': instance.bP_Systolic,
  'bP_Diastolic': instance.bP_Diastolic,
  'heartRate': instance.heartRate,
  'respRate': instance.respRate,
  'pulseOxy': instance.pulseOxy,
  'supplementalOxygen': instance.supplementalOxygen,
  'consciousnessLevel':
      _$ConsciousnessLevelEnumMap[instance.consciousnessLevel],
  'recordedAt': instance.recordedAt,
  'nurseId': instance.nurseId,
};

const _$ConsciousnessLevelEnumMap = {
  ConsciousnessLevel.value0: 0,
  ConsciousnessLevel.value1: 1,
  ConsciousnessLevel.value2: 2,
  ConsciousnessLevel.value3: 3,
};
