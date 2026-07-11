import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String? roomId;
  final String? roomNumber;
  final int? type;
  final int? floor;
  final List<BedModel>? beds;

  const RoomModel({
    this.roomId,
    this.roomNumber,
    this.type,
    this.floor,
    this.beds,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  String get roomTypeLabel {
    switch (type) {
      case 0: return 'Ward';
      case 1: return 'Private';
      case 2: return 'ICU';
      case 3: return 'Emergency';
      case 4: return 'Operation';
      default: return 'Unknown';
    }
  }

  List<BedModel> get availableBeds =>
      beds?.where((b) => b.status == 0).toList() ?? [];
}

@JsonSerializable()
class BedModel {
  final String? bedId;
  final String? bedNumber;
  final int? status; // 0 = available, 1 = occupied
  final String? currentAdmissionId;

  const BedModel({
    this.bedId,
    this.bedNumber,
    this.status,
    this.currentAdmissionId,
  });

  factory BedModel.fromJson(Map<String, dynamic> json) =>
      _$BedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedModelToJson(this);

  bool get isAvailable => status == 0;
}
