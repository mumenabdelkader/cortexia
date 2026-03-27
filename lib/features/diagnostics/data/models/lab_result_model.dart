import 'package:json_annotation/json_annotation.dart';

part 'lab_result_model.g.dart';

@JsonSerializable()
class LabResultModel {
  final String? id;
  final String? parameter;
  final double? value;
  final String? unit;
  final String? referenceRange;
  final String? sampleDate;
  final String? labOrderId;
  final String? nurseId;

  const LabResultModel({
    this.id,
    this.parameter,
    this.value,
    this.unit,
    this.referenceRange,
    this.sampleDate,
    this.labOrderId,
    this.nurseId,
  });

  factory LabResultModel.fromJson(Map<String, dynamic> json) =>
      _$LabResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabResultModelToJson(this);
}
