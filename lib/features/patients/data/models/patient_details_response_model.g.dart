// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientDetailsResponseModel _$PatientDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => PatientDetailsResponseModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  fileNumber: json['fileNumber'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: json['gender'] as String?,
  diagnosisSummary: json['diagnosisSummary'] as String?,
  bloodType: json['bloodType'] as String?,
  nationalId: json['nationalId'] as String?,
  admissions: (json['admissions'] as List<dynamic>?)
      ?.map((e) => PatientAdmissionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PatientDetailsResponseModelToJson(
  PatientDetailsResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'fileNumber': instance.fileNumber,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'dateOfBirth': instance.dateOfBirth,
  'gender': instance.gender,
  'diagnosisSummary': instance.diagnosisSummary,
  'bloodType': instance.bloodType,
  'nationalId': instance.nationalId,
  'admissions': instance.admissions,
};

PatientAdmissionModel _$PatientAdmissionModelFromJson(
  Map<String, dynamic> json,
) => PatientAdmissionModel(
  id: json['id'] as String?,
  admissionDate: json['admissionDate'] as String?,
  dischargeDate: json['dischargeDate'] as String?,
  initialDiagnosis: json['initialDiagnosis'] as String?,
  status: (json['status'] as num?)?.toInt(),
  patientId: json['patientId'] as String?,
  doctorId: json['doctorId'] as String?,
  roomId: json['roomId'] as String?,
  bedId: json['bedId'] as String?,
);

Map<String, dynamic> _$PatientAdmissionModelToJson(
  PatientAdmissionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'admissionDate': instance.admissionDate,
  'dischargeDate': instance.dischargeDate,
  'initialDiagnosis': instance.initialDiagnosis,
  'status': instance.status,
  'patientId': instance.patientId,
  'doctorId': instance.doctorId,
  'roomId': instance.roomId,
  'bedId': instance.bedId,
};
