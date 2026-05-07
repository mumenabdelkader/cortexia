// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fluid_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FluidBalanceModel _$FluidBalanceModelFromJson(Map<String, dynamic> json) =>
    FluidBalanceModel(
      id: json['id'] as String?,
      recordedAt: json['recordedAt'] as String?,
      category: $enumDecodeNullable(
        _$FluidBalanceCategoryEnumMap,
        json['category'],
      ),
      type: $enumDecodeNullable(_$FluidTypeEnumMap, json['type']),
      amountMl: (json['amountMl'] as num?)?.toInt(),
      admissionId: json['admissionId'] as String?,
      nurseId: json['nurseId'] as String?,
    );

Map<String, dynamic> _$FluidBalanceModelToJson(FluidBalanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recordedAt': instance.recordedAt,
      'category': _$FluidBalanceCategoryEnumMap[instance.category],
      'type': _$FluidTypeEnumMap[instance.type],
      'amountMl': instance.amountMl,
      'admissionId': instance.admissionId,
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
