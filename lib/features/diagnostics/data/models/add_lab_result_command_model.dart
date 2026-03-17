import 'package:json_annotation/json_annotation.dart';

part 'add_lab_result_command_model.g.dart';

@JsonSerializable()
class AddLabResultCommandModel {
  String? labOrderId;
  String? parameter;
  double? value;
  String? unit;
  String? referenceRange;
  String? sampleDate;
  String? nurseId;

  AddLabResultCommandModel({this.labOrderId, this.parameter, this.value, this.unit, this.referenceRange, this.sampleDate, this.nurseId});

  factory AddLabResultCommandModel.fromJson(Map<String, dynamic> json) => _$AddLabResultCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddLabResultCommandModelToJson(this);
}
