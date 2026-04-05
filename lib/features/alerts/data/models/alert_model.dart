import 'package:json_annotation/json_annotation.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'alertMessage')
  final String? alertMessage;

  @JsonKey(name: 'severity')
  final int? severity;

  @JsonKey(name: 'generatedAt')
  final String? generatedAt;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'admissionId')
  final String? admissionId;

  AlertModel({
    this.id,
    this.alertMessage,
    this.severity,
    this.generatedAt,
    this.status,
    this.admissionId,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}
