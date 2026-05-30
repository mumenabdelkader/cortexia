// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
  roomId: json['roomId'] as String?,
  roomNumber: json['roomNumber'] as String?,
  roomType: $enumDecodeNullable(_$RoomTypeEnumMap, json['type']),
  floor: (json['floor'] as num?)?.toInt(),
  beds: (json['beds'] as List<dynamic>?)
      ?.map((e) => BedModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  capacity: (json['capacity'] as num?)?.toInt(),
  isAvailable: json['isAvailable'] as bool?,
);

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
  'roomId': instance.roomId,
  'roomNumber': instance.roomNumber,
  'type': _$RoomTypeEnumMap[instance.roomType],
  'floor': instance.floor,
  'beds': instance.beds,
  'capacity': instance.capacity,
  'isAvailable': instance.isAvailable,
};

const _$RoomTypeEnumMap = {
  RoomType.general: 0,
  RoomType.icu: 1,
  RoomType.surgery: 2,
  RoomType.emergency: 3,
  RoomType.or: 4,
};
