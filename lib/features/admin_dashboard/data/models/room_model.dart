import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/admin_dashboard/data/models/bed_model.dart';

part 'room_model.g.dart';

/// Room type enum matching API int values
enum RoomType {
  @JsonValue(0)
  general,
  @JsonValue(1)
  icu,
  @JsonValue(2)
  surgery,
  @JsonValue(3)
  emergency,
  @JsonValue(4)
  or,
}

@JsonSerializable()
class RoomModel {
  final String? roomId;
  final String? roomNumber;
  @JsonKey(name: 'type')
  final RoomType? roomType;
  final int? floor;
  final List<BedModel>? beds;

  // The following fields were in the original model, keeping them if needed by forms
  final int? capacity;
  final bool? isAvailable;

  const RoomModel({
    this.roomId,
    this.roomNumber,
    this.roomType,
    this.floor,
    this.beds,
    this.capacity,
    this.isAvailable,
  });

  String get roomTypeLabel {
    switch (roomType) {
      case RoomType.icu:
        return 'ICU';
      case RoomType.surgery:
        return 'Surgery';
      case RoomType.emergency:
        return 'Emergency';
      case RoomType.or:
        return 'OR';
      case RoomType.general:
      default:
        return 'General';
    }
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
