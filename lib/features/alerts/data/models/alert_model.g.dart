// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) => AlertModel(
  id: json['id'] as String?,
  alertMessage: json['alertMessage'] as String?,
  severity: (json['severity'] as num?)?.toInt(),
  generatedAt: json['generatedAt'] as String?,
  status: (json['status'] as num?)?.toInt(),
  admissionId: json['admissionId'] as String?,
);

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alertMessage': instance.alertMessage,
      'severity': instance.severity,
      'generatedAt': instance.generatedAt,
      'status': instance.status,
      'admissionId': instance.admissionId,
    };
