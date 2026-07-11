import 'package:json_annotation/json_annotation.dart';

part 'admission_response_body.g.dart';

@JsonSerializable()
class AdmissionResponseBody {
  final String? nationalId;
  final String? patientId;
  final String? fileNumber;
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? email;
  final String? phone;
  final String? admissionId;
  final String? admissionDate;
  final String? initialDiagnosis;
  final String? status;
  final String? bedId;
  final String? roomId;

  AdmissionResponseBody({
    this.nationalId,
    this.patientId,
    this.fileNumber,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.email,
    this.phone,
    this.admissionId,
    this.admissionDate,
    this.initialDiagnosis,
    this.status,
    this.bedId,
    this.roomId,
  });

  factory AdmissionResponseBody.fromJson(Map<String, dynamic> json) =>
      _$AdmissionResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AdmissionResponseBodyToJson(this);
}
