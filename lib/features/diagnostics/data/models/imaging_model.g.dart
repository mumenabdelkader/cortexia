// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imaging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagingModel _$ImagingModelFromJson(Map<String, dynamic> json) => ImagingModel(
  id: json['id'] as String?,
  type: (json['type'] as num?)?.toInt(),
  findings: json['findings'] as String?,
  date: json['date'] as String?,
  admissionId: json['admissionId'] as String?,
  doctorId: json['doctorId'] as String?,
  files: (json['files'] as List<dynamic>?)
      ?.map((e) => ImagingFileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ImagingModelToJson(ImagingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'findings': instance.findings,
      'date': instance.date,
      'admissionId': instance.admissionId,
      'doctorId': instance.doctorId,
      'files': instance.files,
    };
