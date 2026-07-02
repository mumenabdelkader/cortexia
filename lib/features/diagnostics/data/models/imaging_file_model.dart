import 'package:json_annotation/json_annotation.dart';

part 'imaging_file_model.g.dart';

@JsonSerializable()
class ImagingFileModel {
  final String? id;
  final String? url;
  final String? publicId;
  final String? fileName;
  final int? size;

  const ImagingFileModel({
    this.id,
    this.url,
    this.publicId,
    this.fileName,
    this.size,
  });

  factory ImagingFileModel.fromJson(Map<String, dynamic> json) =>
      _$ImagingFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImagingFileModelToJson(this);
}
