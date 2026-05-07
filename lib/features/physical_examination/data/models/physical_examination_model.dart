import 'package:json_annotation/json_annotation.dart';

part 'physical_examination_model.g.dart';

@JsonSerializable()
class PhysicalExaminationModel {
  final String? id;
  final String? examDate;
  final double? temperature;
  final String? bloodPressure;
  final int? pulse;
  final int? respRate;
  final String? eyeStatus;
  final String? skinStatus;
  final String? lipsStatus;
  final String? heartExam;
  final String? abdomenExam;
  final String? localExamination;
  final String? admissionId;
  final String? doctorId;

  PhysicalExaminationModel({
    this.id,
    this.examDate,
    this.temperature,
    this.bloodPressure,
    this.pulse,
    this.respRate,
    this.eyeStatus,
    this.skinStatus,
    this.lipsStatus,
    this.heartExam,
    this.abdomenExam,
    this.localExamination,
    this.admissionId,
    this.doctorId,
  });

  factory PhysicalExaminationModel.fromJson(Map<String, dynamic> json) => _$PhysicalExaminationModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhysicalExaminationModelToJson(this);
}
