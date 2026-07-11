// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_admission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveAdmissionModel _$ActiveAdmissionModelFromJson(
  Map<String, dynamic> json,
) => ActiveAdmissionModel(
  admissionId: json['admissionId'] as String?,
  nationalId: json['nationalId'] as String?,
  patientId: json['patientId'] as String?,
  fileNumber: json['fileNumber'] as String?,
  name: json['name'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  age: (json['age'] as num?)?.toInt(),
  gender: (json['gender'] as num?)?.toInt(),
  bloodType: (json['bloodType'] as num?)?.toInt(),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  admissionDate: json['admissionDate'] as String?,
  initialDiagnosis: json['initialDiagnosis'] as String?,
  status: json['status'] as String?,
  diagnosisSummary: json['diagnosisSummary'] as String?,
  bedId: json['bedId'] as String?,
  roomId: json['roomId'] as String?,
  latestVitalSigns: json['latestVitalSigns'] == null
      ? null
      : LatestVitalSignsModel.fromJson(
          json['latestVitalSigns'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ActiveAdmissionModelToJson(
  ActiveAdmissionModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'nationalId': instance.nationalId,
  'patientId': instance.patientId,
  'fileNumber': instance.fileNumber,
  'name': instance.name,
  'dateOfBirth': instance.dateOfBirth,
  'age': instance.age,
  'gender': instance.gender,
  'bloodType': instance.bloodType,
  'email': instance.email,
  'phone': instance.phone,
  'admissionDate': instance.admissionDate,
  'initialDiagnosis': instance.initialDiagnosis,
  'status': instance.status,
  'diagnosisSummary': instance.diagnosisSummary,
  'bedId': instance.bedId,
  'roomId': instance.roomId,
  'latestVitalSigns': instance.latestVitalSigns,
};

LatestVitalSignsModel _$LatestVitalSignsModelFromJson(
  Map<String, dynamic> json,
) => LatestVitalSignsModel(
  temperature: json['temperature'] as num?,
  heartRate: json['heartRate'] as num?,
  respRate: json['respRate'] as num?,
  bpSystolic: json['bpSystolic'] as num?,
  bpDiastolic: json['bpDiastolic'] as num?,
  pulseOxy: json['pulseOxy'] as num?,
  gcsTotal: json['gcsTotal'] as num?,
  recordedAt: json['recordedAt'] as String?,
);

Map<String, dynamic> _$LatestVitalSignsModelToJson(
  LatestVitalSignsModel instance,
) => <String, dynamic>{
  'temperature': instance.temperature,
  'heartRate': instance.heartRate,
  'respRate': instance.respRate,
  'bpSystolic': instance.bpSystolic,
  'bpDiastolic': instance.bpDiastolic,
  'pulseOxy': instance.pulseOxy,
  'gcsTotal': instance.gcsTotal,
  'recordedAt': instance.recordedAt,
};
