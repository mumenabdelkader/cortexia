import 'package:json_annotation/json_annotation.dart';

part 'admission_request_body.g.dart';

@JsonSerializable()
class AdmissionRequestBody {
  final String patientId;
  final String doctorId;
  final String admissionDate;
  final String initialDiagnosis;
  final String roomId;
  final String bedId;

  AdmissionRequestBody({
    required this.patientId,
    required this.doctorId,
    required this.admissionDate,
    required this.initialDiagnosis,
    required this.roomId,
    required this.bedId,
  });

  factory AdmissionRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AdmissionRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AdmissionRequestBodyToJson(this);
}
