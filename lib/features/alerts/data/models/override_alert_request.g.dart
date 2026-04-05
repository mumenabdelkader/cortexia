// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'override_alert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverrideAlertRequest _$OverrideAlertRequestFromJson(
  Map<String, dynamic> json,
) => OverrideAlertRequest(
  alertId: json['alertId'] as String,
  doctorId: json['doctorId'] as String,
  reason: json['reason'] as String,
  procedureId: json['procedureId'] as String,
);

Map<String, dynamic> _$OverrideAlertRequestToJson(
  OverrideAlertRequest instance,
) => <String, dynamic>{
  'alertId': instance.alertId,
  'doctorId': instance.doctorId,
  'reason': instance.reason,
  'procedureId': instance.procedureId,
};
