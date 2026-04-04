import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/patients/data/models/blood_type.dart';
import 'package:cortexia/features/patients/data/models/gender.dart';

part 'admit_patient_command.g.dart';

@JsonSerializable()
class AdmitPatientCommand {
  final String? name;
  final String? nationalId;
  final String? dateOfBirth;
  final Gender? gender;
  final String? email;
  final String? phone;
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final BloodType? bloodType;
  final String? diagnosisSummary;
  final String? doctorId;
  final String? initialDiagnosis;
  final String? bedId;
  final String? roomId;

  const AdmitPatientCommand({
    this.name,
    this.nationalId,
    this.dateOfBirth,
    this.gender,
    this.email,
    this.phone,
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.bloodType,
    this.diagnosisSummary,
    this.doctorId,
    this.initialDiagnosis,
    this.bedId,
    this.roomId,
  });

  factory AdmitPatientCommand.fromJson(Map<String, dynamic> json) =>
      _$AdmitPatientCommandFromJson(json);

  Map<String, dynamic> toJson() => _$AdmitPatientCommandToJson(this);
}
