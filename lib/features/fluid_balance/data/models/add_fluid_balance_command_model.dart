import 'package:cortexia/features/fluid_balance/data/models/fluid_type.dart';
import 'package:cortexia/features/fluid_balance/data/models/fluid_balance_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_fluid_balance_command_model.g.dart';

@JsonSerializable()
class AddFluidBalanceCommandModel {
  String? admissionId;
  String? id;
  FluidBalanceCategory? category;
  FluidType? type;
  int? amountMl;
  String? recordedAt;
  String? nurseId;

  AddFluidBalanceCommandModel({this.admissionId, this.id, this.category, this.type, this.amountMl, this.recordedAt, this.nurseId});

  factory AddFluidBalanceCommandModel.fromJson(Map<String, dynamic> json) => _$AddFluidBalanceCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddFluidBalanceCommandModelToJson(this);
}
