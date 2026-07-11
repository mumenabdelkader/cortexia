// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_intervention_procedure_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInterventionProcedureCommandModel
_$AddInterventionProcedureCommandModelFromJson(Map<String, dynamic> json) =>
    AddInterventionProcedureCommandModel(
      id: json['id'] as String?,
      type: $enumDecodeNullable(_$CareInterventionTypeEnumMap, json['type']),
      size: (json['size'] as num?)?.toInt(),
      insertionDate: json['insertionDate'] as String?,
      removalDate: json['removalDate'] as String?,
      admissionId: json['admissionId'] as String?,
      nurseId: json['nurseId'] as String?,
    );

Map<String, dynamic> _$AddInterventionProcedureCommandModelToJson(
  AddInterventionProcedureCommandModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$CareInterventionTypeEnumMap[instance.type],
  'size': instance.size,
  'insertionDate': instance.insertionDate,
  'removalDate': instance.removalDate,
  'admissionId': instance.admissionId,
  'nurseId': instance.nurseId,
};

const _$CareInterventionTypeEnumMap = {
  CareInterventionType.ivCannula: 0,
  CareInterventionType.urinaryCatheter: 1,
  CareInterventionType.ngTube: 2,
  CareInterventionType.centralLine: 3,
  CareInterventionType.woundDrain: 4,
};
