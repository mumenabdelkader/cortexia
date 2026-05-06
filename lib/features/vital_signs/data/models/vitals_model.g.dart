// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalsModel _$VitalsModelFromJson(Map<String, dynamic> json) => VitalsModel(
  id: json['id'] as String?,
  recordedAt: json['recordedAt'] as String?,
  temperature: (json['temperature'] as num?)?.toDouble(),
  heartRate: (json['heartRate'] as num?)?.toInt(),
  respRate: (json['respRate'] as num?)?.toInt(),
  bpSystolic: (VitalsModel._readBpSystolic(json, 'bpSystolic') as num?)
      ?.toInt(),
  bpDiastolic: (VitalsModel._readBpDiastolic(json, 'bpDiastolic') as num?)
      ?.toInt(),
  pulseOxy: (json['pulseOxy'] as num?)?.toInt(),
  cvp: (json['cvp'] as num?)?.toDouble(),
  insulinGiven: json['insulinGiven'] as String?,
  gcsEye: (json['gcsEye'] as num?)?.toInt(),
  gcsVerbal: (json['gcsVerbal'] as num?)?.toInt(),
  gcsMotor: (json['gcsMotor'] as num?)?.toInt(),
  gcsTotal: (json['gcsTotal'] as num?)?.toInt(),
  supplementalOxygen: json['supplementalOxygen'] as bool?,
  consciousnessLevel: (json['consciousnessLevel'] as num?)?.toInt(),
  newsScore: (json['newsScore'] as num?)?.toInt(),
  newsRiskLevel: (json['newsRiskLevel'] as num?)?.toInt(),
  admissionId: json['admissionId'] as String?,
  nurseId: json['nurseId'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$VitalsModelToJson(VitalsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recordedAt': instance.recordedAt,
      'temperature': instance.temperature,
      'heartRate': instance.heartRate,
      'respRate': instance.respRate,
      'bpSystolic': instance.bpSystolic,
      'bpDiastolic': instance.bpDiastolic,
      'pulseOxy': instance.pulseOxy,
      'cvp': instance.cvp,
      'insulinGiven': instance.insulinGiven,
      'gcsEye': instance.gcsEye,
      'gcsVerbal': instance.gcsVerbal,
      'gcsMotor': instance.gcsMotor,
      'gcsTotal': instance.gcsTotal,
      'supplementalOxygen': instance.supplementalOxygen,
      'consciousnessLevel': instance.consciousnessLevel,
      'newsScore': instance.newsScore,
      'newsRiskLevel': instance.newsRiskLevel,
      'admissionId': instance.admissionId,
      'nurseId': instance.nurseId,
      'doctorId': instance.doctorId,
    };
