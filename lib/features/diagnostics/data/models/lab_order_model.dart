import 'package:json_annotation/json_annotation.dart';
import 'lab_result_model.dart';

part 'lab_order_model.g.dart';

@JsonSerializable()
class LabOrderModel {
  final String? id;
  final String? testName;
  final String? orderDate;
  final String? admissionId;
  final String? doctorId;
  final List<LabResultModel>? results;

  const LabOrderModel({
    this.id,
    this.testName,
    this.orderDate,
    this.admissionId,
    this.doctorId,
    this.results,
  });

  factory LabOrderModel.fromJson(Map<String, dynamic> json) =>
      _$LabOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabOrderModelToJson(this);
}
