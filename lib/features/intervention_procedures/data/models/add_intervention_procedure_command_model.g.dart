// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_intervention_procedure_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInterventionProcedureCommandModel
_$AddInterventionProcedureCommandModelFromJson(Map<String, dynamic> json) =>
    AddInterventionProcedureCommandModel(
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
  'type': _$CareInterventionTypeEnumMap[instance.type],
  'size': instance.size,
  'insertionDate': instance.insertionDate,
  'removalDate': instance.removalDate,
  'admissionId': instance.admissionId,
  'nurseId': instance.nurseId,
};

const _$CareInterventionTypeEnumMap = {
  CareInterventionType.value0: 0,
  CareInterventionType.value1: 1,
  CareInterventionType.value2: 2,
  CareInterventionType.value3: 3,
  CareInterventionType.value4: 4,
};
