import 'package:json_annotation/json_annotation.dart';

part 'prescribe_medication_response_model.g.dart';

@JsonSerializable()
class PrescribeMedicationResponseModel {
  final String? id;

  PrescribeMedicationResponseModel({this.id});

  factory PrescribeMedicationResponseModel.fromJson(Map<String, dynamic> json) => _$PrescribeMedicationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescribeMedicationResponseModelToJson(this);
}
