// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabResultModel _$LabResultModelFromJson(Map<String, dynamic> json) =>
    LabResultModel(
      id: json['id'] as String?,
      parameter: json['parameter'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      referenceRange: json['referenceRange'] as String?,
      sampleDate: json['sampleDate'] as String?,
      labOrderId: json['labOrderId'] as String?,
      nurseId: json['nurseId'] as String?,
    );

Map<String, dynamic> _$LabResultModelToJson(LabResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parameter': instance.parameter,
      'value': instance.value,
      'unit': instance.unit,
      'referenceRange': instance.referenceRange,
      'sampleDate': instance.sampleDate,
      'labOrderId': instance.labOrderId,
      'nurseId': instance.nurseId,
    };
