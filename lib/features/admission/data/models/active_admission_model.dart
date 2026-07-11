import 'package:json_annotation/json_annotation.dart';

part 'active_admission_model.g.dart';

@JsonSerializable()
class ActiveAdmissionModel {
  @JsonKey(name: 'admissionId')
  final String? admissionId;

  @JsonKey(name: 'nationalId')
  final String? nationalId;

  @JsonKey(name: 'patientId')
  final String? patientId;

  @JsonKey(name: 'fileNumber')
  final String? fileNumber;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;

  @JsonKey(name: 'age')
  final int? age;

  @JsonKey(name: 'gender')
  final int? gender;

  @JsonKey(name: 'bloodType')
  final int? bloodType;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'admissionDate')
  final String? admissionDate;

  @JsonKey(name: 'initialDiagnosis')
  final String? initialDiagnosis;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'diagnosisSummary')
  final String? diagnosisSummary;

  @JsonKey(name: 'bedId')
  final String? bedId;

  @JsonKey(name: 'roomId')
  final String? roomId;

  @JsonKey(name: 'latestVitalSigns')
  final LatestVitalSignsModel? latestVitalSigns;

  ActiveAdmissionModel({
    this.admissionId,
    this.nationalId,
    this.patientId,
    this.fileNumber,
    this.name,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.bloodType,
    this.email,
    this.phone,
    this.admissionDate,
    this.initialDiagnosis,
    this.status,
    this.diagnosisSummary,
    this.bedId,
    this.roomId,
    this.latestVitalSigns,
  });

  factory ActiveAdmissionModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveAdmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveAdmissionModelToJson(this);
}

@JsonSerializable()
class LatestVitalSignsModel {
  @JsonKey(name: 'temperature')
  final num? temperature;

  @JsonKey(name: 'heartRate')
  final num? heartRate;

  @JsonKey(name: 'respRate')
  final num? respRate;

  @JsonKey(name: 'bpSystolic')
  final num? bpSystolic;

  @JsonKey(name: 'bpDiastolic')
  final num? bpDiastolic;

  @JsonKey(name: 'pulseOxy')
  final num? pulseOxy;

  @JsonKey(name: 'gcsTotal')
  final num? gcsTotal;

  @JsonKey(name: 'recordedAt')
  final String? recordedAt;

  LatestVitalSignsModel({
    this.temperature,
    this.heartRate,
    this.respRate,
    this.bpSystolic,
    this.bpDiastolic,
    this.pulseOxy,
    this.gcsTotal,
    this.recordedAt,
  });

  factory LatestVitalSignsModel.fromJson(Map<String, dynamic> json) =>
      _$LatestVitalSignsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LatestVitalSignsModelToJson(this);
}
