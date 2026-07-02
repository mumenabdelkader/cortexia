// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imaging_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagingFileModel _$ImagingFileModelFromJson(Map<String, dynamic> json) =>
    ImagingFileModel(
      id: json['id'] as String?,
      url: json['url'] as String?,
      publicId: json['publicId'] as String?,
      fileName: json['fileName'] as String?,
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImagingFileModelToJson(ImagingFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'publicId': instance.publicId,
      'fileName': instance.fileName,
      'size': instance.size,
    };
