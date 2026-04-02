// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_fluid_balance_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFluidBalanceCommandModel _$AddFluidBalanceCommandModelFromJson(
  Map<String, dynamic> json,
) => AddFluidBalanceCommandModel(
  admissionId: json['admissionId'] as String?,
  id: json['id'] as String?,
  category: $enumDecodeNullable(
    _$FluidBalanceCategoryEnumMap,
    json['category'],
  ),
  type: $enumDecodeNullable(_$FluidTypeEnumMap, json['type']),
  amountMl: (json['amountMl'] as num?)?.toInt(),
  recordedAt: json['recordedAt'] as String?,
  nurseId: json['nurseId'] as String?,
);

Map<String, dynamic> _$AddFluidBalanceCommandModelToJson(
  AddFluidBalanceCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'id': instance.id,
  'category': _$FluidBalanceCategoryEnumMap[instance.category],
  'type': _$FluidTypeEnumMap[instance.type],
  'amountMl': instance.amountMl,
  'recordedAt': instance.recordedAt,
  'nurseId': instance.nurseId,
};

const _$FluidBalanceCategoryEnumMap = {
  FluidBalanceCategory.intake: 0,
  FluidBalanceCategory.output: 1,
};

const _$FluidTypeEnumMap = {
  FluidType.oral: 0,
  FluidType.iv: 1,
  FluidType.urine: 2,
  FluidType.drain: 3,
};
