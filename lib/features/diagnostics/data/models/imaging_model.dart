import 'package:json_annotation/json_annotation.dart';

part 'imaging_model.g.dart';

@JsonSerializable()
class ImagingModel {
  final String? id;
  final int? type;
  final String? findings;
  final String? date;
  final String? admissionId;
  final String? doctorId;

  const ImagingModel({
    this.id,
    this.type,
    this.findings,
    this.date,
    this.admissionId,
    this.doctorId,
  });

  factory ImagingModel.fromJson(Map<String, dynamic> json) =>
      _$ImagingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImagingModelToJson(this);
}
