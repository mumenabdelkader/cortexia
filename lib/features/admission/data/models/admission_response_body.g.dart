// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admission_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmissionResponseBody _$AdmissionResponseBodyFromJson(
  Map<String, dynamic> json,
) => AdmissionResponseBody(
  nationalId: json['nationalId'] as String?,
  patientId: json['patientId'] as String?,
  fileNumber: json['fileNumber'] as String?,
  name: json['name'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: json['gender'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  admissionId: json['admissionId'] as String?,
  admissionDate: json['admissionDate'] as String?,
  initialDiagnosis: json['initialDiagnosis'] as String?,
  status: json['status'] as String?,
  bedId: json['bedId'] as String?,
  roomId: json['roomId'] as String?,
);

Map<String, dynamic> _$AdmissionResponseBodyToJson(
  AdmissionResponseBody instance,
) => <String, dynamic>{
  'nationalId': instance.nationalId,
  'patientId': instance.patientId,
  'fileNumber': instance.fileNumber,
  'name': instance.name,
  'dateOfBirth': instance.dateOfBirth,
  'gender': instance.gender,
  'email': instance.email,
  'phone': instance.phone,
  'admissionId': instance.admissionId,
  'admissionDate': instance.admissionDate,
  'initialDiagnosis': instance.initialDiagnosis,
  'status': instance.status,
  'bedId': instance.bedId,
  'roomId': instance.roomId,
};
