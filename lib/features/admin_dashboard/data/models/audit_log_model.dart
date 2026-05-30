import 'package:json_annotation/json_annotation.dart';

part 'audit_log_model.g.dart';

@JsonSerializable()
class AuditLogModel {
  final int id;
  final String? entityId;
  final String? entityName;
  final int type;
  final String? oldValue;
  final String? newValue;
  final String? affectedColumns;
  final String timestamp;
  final String? userId;

  const AuditLogModel({
    required this.id,
    this.entityId,
    this.entityName,
    required this.type,
    this.oldValue,
    this.newValue,
    this.affectedColumns,
    required this.timestamp,
    this.userId,
  });

  /// Returns human-readable action type
  String get actionLabel {
    switch (type) {
      case 0:
        return 'Create';
      case 1:
        return 'Update';
      case 2:
        return 'Delete';
      default:
        return 'Unknown';
    }
  }

  factory AuditLogModel.fromJson(Map<String, dynamic> json) =>
      _$AuditLogModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuditLogModelToJson(this);
}
