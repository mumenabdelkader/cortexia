import 'package:cortexia/features/vital_signs/data/models/consciousness_level.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_vitals_command_model.g.dart';

@JsonSerializable()
class RecordVitalsCommandModel {
  String? admissionId;
  String? id;
  double? temperature;
  int? bP_Systolic;
  int? bP_Diastolic;
  int? heartRate;
  int? respRate;
  int? pulseOxy;
  bool? supplementalOxygen;
  ConsciousnessLevel? consciousnessLevel;
  String? recordedAt;
  String? nurseId;

  RecordVitalsCommandModel({this.admissionId, this.id, this.temperature, this.bP_Systolic, this.bP_Diastolic, this.heartRate, this.respRate, this.pulseOxy, this.supplementalOxygen, this.consciousnessLevel, this.recordedAt, this.nurseId});

  factory RecordVitalsCommandModel.fromJson(Map<String, dynamic> json) => _$RecordVitalsCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordVitalsCommandModelToJson(this);
}
