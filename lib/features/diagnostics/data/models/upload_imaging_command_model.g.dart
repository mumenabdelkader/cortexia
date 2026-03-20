// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_imaging_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImagingCommandModel _$UploadImagingCommandModelFromJson(
  Map<String, dynamic> json,
) => UploadImagingCommandModel(
  admissionId: json['admissionId'] as String?,
  type: $enumDecodeNullable(_$ImagingTypeEnumMap, json['type']),
  findings: json['findings'] as String?,
  date: json['date'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$UploadImagingCommandModelToJson(
  UploadImagingCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'type': _$ImagingTypeEnumMap[instance.type],
  'findings': instance.findings,
  'date': instance.date,
  'doctorId': instance.doctorId,
};

const _$ImagingTypeEnumMap = {
  ImagingType.value0: 0,
  ImagingType.value1: 1,
  ImagingType.value2: 2,
  ImagingType.value3: 3,
  ImagingType.value4: 4,
  ImagingType.value5: 5,
};
