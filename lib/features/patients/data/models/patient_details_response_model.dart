import 'package:json_annotation/json_annotation.dart';

part 'patient_details_response_model.g.dart';

@JsonSerializable()
class PatientDetailsResponseModel {
  final String? id;
  final String? name;
  final String? fileNumber;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? diagnosisSummary;
  final String? bloodType;
  final String? nationalId;
  final List<PatientAdmissionModel>? admissions;

  PatientDetailsResponseModel({
    this.id,
    this.name,
    this.fileNumber,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.diagnosisSummary,
    this.bloodType,
    this.nationalId,
    this.admissions,
  });

  factory PatientDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PatientDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDetailsResponseModelToJson(this);
}

@JsonSerializable()
class PatientAdmissionModel {
  final String? id;
  final String? admissionDate;
  final String? dischargeDate;
  final String? initialDiagnosis;
  final int? status;
  final String? patientId;
  final String? doctorId;
  final String? roomId;
  final String? bedId;

  PatientAdmissionModel({
    this.id,
    this.admissionDate,
    this.dischargeDate,
    this.initialDiagnosis,
    this.status,
    this.patientId,
    this.doctorId,
    this.roomId,
    this.bedId,
  });

  factory PatientAdmissionModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAdmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdmissionModelToJson(this);
}
