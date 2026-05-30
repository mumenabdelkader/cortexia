// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BedModel _$BedModelFromJson(Map<String, dynamic> json) => BedModel(
  bedId: json['bedId'] as String?,
  bedNumber: json['bedNumber'] as String?,
  status: $enumDecodeNullable(_$BedStatusEnumMap, json['status']),
  currentAdmissionId: json['currentAdmissionId'] as String?,
  roomId: json['roomId'] as String?,
);

Map<String, dynamic> _$BedModelToJson(BedModel instance) => <String, dynamic>{
  'bedId': instance.bedId,
  'bedNumber': instance.bedNumber,
  'status': _$BedStatusEnumMap[instance.status],
  'currentAdmissionId': instance.currentAdmissionId,
  'roomId': instance.roomId,
};

const _$BedStatusEnumMap = {
  BedStatus.available: 0,
  BedStatus.occupied: 1,
  BedStatus.maintenance: 2,
};
