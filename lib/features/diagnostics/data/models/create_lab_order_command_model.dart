import 'package:json_annotation/json_annotation.dart';

part 'create_lab_order_command_model.g.dart';

@JsonSerializable()
class CreateLabOrderCommandModel {
  String? admissionId;
  String? testName;
  String? orderDate;
  String? doctorId;

  CreateLabOrderCommandModel({this.admissionId, this.testName, this.orderDate, this.doctorId});

  factory CreateLabOrderCommandModel.fromJson(Map<String, dynamic> json) => _$CreateLabOrderCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLabOrderCommandModelToJson(this);
}
