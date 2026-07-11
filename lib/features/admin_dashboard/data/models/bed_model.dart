import 'package:json_annotation/json_annotation.dart';

part 'bed_model.g.dart';

/// Bed status enum matching API int values
enum BedStatus {
  @JsonValue(0)
  available,
  @JsonValue(1)
  occupied,
  @JsonValue(2)
  maintenance,
}

@JsonSerializable()
class BedModel {
  final String? bedId;
  final String? bedNumber;
  final BedStatus? status;
  final String? currentAdmissionId;
  final String? roomId;

  const BedModel({
    this.bedId,
    this.bedNumber,
    this.status,
    this.currentAdmissionId,
    this.roomId,
  });

  String get statusLabel {
    switch (status) {
      case BedStatus.occupied:
        return 'Occupied';
      case BedStatus.maintenance:
        return 'Maintenance';
      case BedStatus.available:
      default:
        return 'Available';
    }
  }

  factory BedModel.fromJson(Map<String, dynamic> json) =>
      _$BedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedModelToJson(this);
}
