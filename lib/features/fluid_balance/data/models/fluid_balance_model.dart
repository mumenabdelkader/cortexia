import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/fluid_balance/data/models/fluid_balance_category.dart';
import 'package:cortexia/features/fluid_balance/data/models/fluid_type.dart';

part 'fluid_balance_model.g.dart';

@JsonSerializable()
class FluidBalanceModel {
  final String? id;
  final String? recordedAt;
  final FluidBalanceCategory? category;
  final FluidType? type;
  final int? amountMl;
  final String? admissionId;
  final String? nurseId;

  FluidBalanceModel({
    this.id,
    this.recordedAt,
    this.category,
    this.type,
    this.amountMl,
    this.admissionId,
    this.nurseId,
  });

  factory FluidBalanceModel.fromJson(Map<String, dynamic> json) => _$FluidBalanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$FluidBalanceModelToJson(this);
}
