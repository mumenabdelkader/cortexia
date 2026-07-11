// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admission_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmissionRequestBody _$AdmissionRequestBodyFromJson(
  Map<String, dynamic> json,
) => AdmissionRequestBody(
  patientId: json['patientId'] as String,
  doctorId: json['doctorId'] as String,
  admissionDate: json['admissionDate'] as String,
  initialDiagnosis: json['initialDiagnosis'] as String,
  roomId: json['roomId'] as String,
  bedId: json['bedId'] as String,
);

Map<String, dynamic> _$AdmissionRequestBodyToJson(
  AdmissionRequestBody instance,
) => <String, dynamic>{
  'patientId': instance.patientId,
  'doctorId': instance.doctorId,
  'admissionDate': instance.admissionDate,
  'initialDiagnosis': instance.initialDiagnosis,
  'roomId': instance.roomId,
  'bedId': instance.bedId,
};
