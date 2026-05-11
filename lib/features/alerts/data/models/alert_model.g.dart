// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) => AlertModel(
  id: json['id'] as String?,
  alertMessage: json['alertMessage'] as String?,
  severity: $enumDecodeNullable(_$AlertSeverityEnumMap, json['severity']),
  generatedAt: json['generatedAt'] as String?,
  status: $enumDecodeNullable(_$AlertStatusEnumMap, json['status']),
  admissionId: json['admissionId'] as String?,
  patientName: json['patientName'] as String?,
);

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alertMessage': instance.alertMessage,
      'severity': _$AlertSeverityEnumMap[instance.severity],
      'generatedAt': instance.generatedAt,
      'status': _$AlertStatusEnumMap[instance.status],
      'admissionId': instance.admissionId,
      'patientName': instance.patientName,
    };

const _$AlertSeverityEnumMap = {
  AlertSeverity.high: 0,
  AlertSeverity.medium: 1,
  AlertSeverity.low: 2,
  AlertSeverity.critical: 3,
  AlertSeverity.info: 4,
};

const _$AlertStatusEnumMap = {
  AlertStatus.active: 0,
  AlertStatus.dismissed: 1,
  AlertStatus.overridden: 2,
  AlertStatus.resolved: 3,
};
