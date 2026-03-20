import 'package:json_annotation/json_annotation.dart';

part 'add_physical_examination_command_model.g.dart';

@JsonSerializable()
class AddPhysicalExaminationCommandModel {
  String? examDate;
  double? temperature;
  String? bloodPressure;
  int? pulse;
  int? respRate;
  String? eyeStatus;
  String? skinStatus;
  String? lipsStatus;
  String? heartExam;
  String? abdomenExam;
  String? localExamination;
  String? admissionId;
  String? doctorId;

  AddPhysicalExaminationCommandModel({this.examDate, this.temperature, this.bloodPressure, this.pulse, this.respRate, this.eyeStatus, this.skinStatus, this.lipsStatus, this.heartExam, this.abdomenExam, this.localExamination, this.admissionId, this.doctorId});

  factory AddPhysicalExaminationCommandModel.fromJson(Map<String, dynamic> json) => _$AddPhysicalExaminationCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddPhysicalExaminationCommandModelToJson(this);
}
