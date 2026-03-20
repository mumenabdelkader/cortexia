import 'package:cortexia/features/diagnostics/data/models/imaging_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_imaging_command_model.g.dart';

@JsonSerializable()
class UploadImagingCommandModel {
  String? admissionId;
  ImagingType? type;
  String? findings;
  String? date;
  String? doctorId;

  UploadImagingCommandModel({this.admissionId, this.type, this.findings, this.date, this.doctorId});

  factory UploadImagingCommandModel.fromJson(Map<String, dynamic> json) => _$UploadImagingCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImagingCommandModelToJson(this);
}
