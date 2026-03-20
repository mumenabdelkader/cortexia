// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_lab_result_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLabResultCommandModel _$AddLabResultCommandModelFromJson(
  Map<String, dynamic> json,
) => AddLabResultCommandModel(
  labOrderId: json['labOrderId'] as String?,
  parameter: json['parameter'] as String?,
  value: (json['value'] as num?)?.toDouble(),
  unit: json['unit'] as String?,
  referenceRange: json['referenceRange'] as String?,
  sampleDate: json['sampleDate'] as String?,
  nurseId: json['nurseId'] as String?,
);

Map<String, dynamic> _$AddLabResultCommandModelToJson(
  AddLabResultCommandModel instance,
) => <String, dynamic>{
  'labOrderId': instance.labOrderId,
  'parameter': instance.parameter,
  'value': instance.value,
  'unit': instance.unit,
  'referenceRange': instance.referenceRange,
  'sampleDate': instance.sampleDate,
  'nurseId': instance.nurseId,
};
