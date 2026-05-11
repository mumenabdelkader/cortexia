import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/alerts/data/models/alert_severity.dart';
import 'package:cortexia/features/alerts/data/models/alert_status.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'alertMessage')
  final String? alertMessage;

  @JsonKey(name: 'severity')
  final AlertSeverity? severity;

  @JsonKey(name: 'generatedAt')
  final String? generatedAt;

  @JsonKey(name: 'status')
  final AlertStatus? status;

  @JsonKey(name: 'admissionId')
  final String? admissionId;

  @JsonKey(name: 'patientName')
  final String? patientName;

  AlertModel({
    this.id,
    this.alertMessage,
    this.severity,
    this.generatedAt,
    this.status,
    this.admissionId,
    this.patientName,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}
