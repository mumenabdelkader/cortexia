import 'package:dio/dio.dart';
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? files;

  UploadImagingCommandModel({
    this.admissionId,
    this.type,
    this.findings,
    this.date,
    this.doctorId,
    this.files,
  });

  factory UploadImagingCommandModel.fromJson(Map<String, dynamic> json) => _$UploadImagingCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImagingCommandModelToJson(this);

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      if (admissionId != null) 'AdmissionId': admissionId,
      if (type != null) 'Type': type!.index,
      if (findings != null) 'Findings': findings,
      if (date != null) 'Date': date,
      if (doctorId != null) 'DoctorId': doctorId,
    });

    if (files != null) {
      for (var path in files!) {
        formData.files.add(
          MapEntry(
            'Files',
            await MultipartFile.fromFile(path),
          ),
        );
      }
    }

    return formData;
  }
}
