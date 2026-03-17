// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_fluid_balance_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFluidBalanceCommandModel _$AddFluidBalanceCommandModelFromJson(
  Map<String, dynamic> json,
) => AddFluidBalanceCommandModel(
  admissionId: json['admissionId'] as String?,
  category: $enumDecodeNullable(
    _$FluidBalanceCategoryEnumMap,
    json['category'],
  ),
  type: $enumDecodeNullable(_$FluidTypeEnumMap, json['type']),
  amount_ML: (json['amount_ML'] as num?)?.toInt(),
  recordedAt: json['recordedAt'] as String?,
  nurseId: json['nurseId'] as String?,
);

Map<String, dynamic> _$AddFluidBalanceCommandModelToJson(
  AddFluidBalanceCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'category': _$FluidBalanceCategoryEnumMap[instance.category],
  'type': _$FluidTypeEnumMap[instance.type],
  'amount_ML': instance.amount_ML,
  'recordedAt': instance.recordedAt,
  'nurseId': instance.nurseId,
};

const _$FluidBalanceCategoryEnumMap = {
  FluidBalanceCategory.value0: 0,
  FluidBalanceCategory.value1: 1,
};

const _$FluidTypeEnumMap = {
  FluidType.value0: 0,
  FluidType.value1: 1,
  FluidType.value2: 2,
  FluidType.value3: 3,
};
