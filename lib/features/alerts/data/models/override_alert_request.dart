import 'package:json_annotation/json_annotation.dart';

part 'override_alert_request.g.dart';

@JsonSerializable()
class OverrideAlertRequest {
  @JsonKey(name: 'alertId')
  final String alertId;

  @JsonKey(name: 'doctorId')
  final String doctorId;

  @JsonKey(name: 'reason')
  final String reason;

  @JsonKey(name: 'procedureId', includeIfNull: false)
  final String? procedureId;

  OverrideAlertRequest({
    required this.alertId,
    required this.doctorId,
    required this.reason,
    this.procedureId,
  });

  factory OverrideAlertRequest.fromJson(Map<String, dynamic> json) =>
      _$OverrideAlertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OverrideAlertRequestToJson(this);
}
