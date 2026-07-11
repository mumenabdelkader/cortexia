// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
  roomId: json['roomId'] as String?,
  roomNumber: json['roomNumber'] as String?,
  type: (json['type'] as num?)?.toInt(),
  floor: (json['floor'] as num?)?.toInt(),
  beds: (json['beds'] as List<dynamic>?)
      ?.map((e) => BedModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
  'roomId': instance.roomId,
  'roomNumber': instance.roomNumber,
  'type': instance.type,
  'floor': instance.floor,
  'beds': instance.beds,
};

BedModel _$BedModelFromJson(Map<String, dynamic> json) => BedModel(
  bedId: json['bedId'] as String?,
  bedNumber: json['bedNumber'] as String?,
  status: (json['status'] as num?)?.toInt(),
  currentAdmissionId: json['currentAdmissionId'] as String?,
);

Map<String, dynamic> _$BedModelToJson(BedModel instance) => <String, dynamic>{
  'bedId': instance.bedId,
  'bedNumber': instance.bedNumber,
  'status': instance.status,
  'currentAdmissionId': instance.currentAdmissionId,
};
