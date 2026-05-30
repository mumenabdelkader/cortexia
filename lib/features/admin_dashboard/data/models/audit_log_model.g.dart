// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditLogModel _$AuditLogModelFromJson(Map<String, dynamic> json) =>
    AuditLogModel(
      id: (json['id'] as num).toInt(),
      entityId: json['entityId'] as String?,
      entityName: json['entityName'] as String?,
      type: (json['type'] as num).toInt(),
      oldValue: json['oldValue'] as String?,
      newValue: json['newValue'] as String?,
      affectedColumns: json['affectedColumns'] as String?,
      timestamp: json['timestamp'] as String,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$AuditLogModelToJson(AuditLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityId': instance.entityId,
      'entityName': instance.entityName,
      'type': instance.type,
      'oldValue': instance.oldValue,
      'newValue': instance.newValue,
      'affectedColumns': instance.affectedColumns,
      'timestamp': instance.timestamp,
      'userId': instance.userId,
    };
