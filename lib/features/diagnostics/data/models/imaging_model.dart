import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/diagnostics/data/models/imaging_file_model.dart';

part 'imaging_model.g.dart';

@JsonSerializable()
class ImagingModel {
  final String? id;
  final int? type;
  final String? findings;
  final String? date;
  final String? admissionId;
  final String? doctorId;
  final List<ImagingFileModel>? files;

  const ImagingModel({
    this.id,
    this.type,
    this.findings,
    this.date,
    this.admissionId,
    this.doctorId,
    this.files,
  });

  factory ImagingModel.fromJson(Map<String, dynamic> json) =>
      _$ImagingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImagingModelToJson(this);
}
