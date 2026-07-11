import 'package:json_annotation/json_annotation.dart';

part 'vitals_model.g.dart';

@JsonSerializable()
class VitalsModel {
  final String? id;
  final String? recordedAt;
  final double? temperature;
  final int? heartRate;
  final int? respRate;
  @JsonKey(name: 'bpSystolic', readValue: _readBpSystolic)
  final int? bpSystolic;
  @JsonKey(name: 'bpDiastolic', readValue: _readBpDiastolic)
  final int? bpDiastolic;
  final int? pulseOxy;
  final double? cvp;
  final String? insulinGiven;
  final int? gcsEye;
  final int? gcsVerbal;
  final int? gcsMotor;
  final int? gcsTotal;
  final bool? supplementalOxygen;
  final int? consciousnessLevel;
  final int? newsScore;
  final int? newsRiskLevel;
  final String? admissionId;
  final String? nurseId;
  final String? doctorId;

  VitalsModel({
    this.id,
    this.recordedAt,
    this.temperature,
    this.heartRate,
    this.respRate,
    this.bpSystolic,
    this.bpDiastolic,
    this.pulseOxy,
    this.cvp,
    this.insulinGiven,
    this.gcsEye,
    this.gcsVerbal,
    this.gcsMotor,
    this.gcsTotal,
    this.supplementalOxygen,
    this.consciousnessLevel,
    this.newsScore,
    this.newsRiskLevel,
    this.admissionId,
    this.nurseId,
    this.doctorId,
  });

  factory VitalsModel.fromJson(Map<String, dynamic> json) => _$VitalsModelFromJson(json);
  Map<String, dynamic> toJson() => _$VitalsModelToJson(this);

  static dynamic _readBpSystolic(Map<dynamic, dynamic> json, String key) {
    return json['bpSystolic'] ?? json['bP_Systolic'];
  }

  static dynamic _readBpDiastolic(Map<dynamic, dynamic> json, String key) {
    return json['bpDiastolic'] ?? json['bP_Diastolic'];
  }
}
