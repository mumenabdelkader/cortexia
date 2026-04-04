// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admit_patient_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdmitPatientCommand _$AdmitPatientCommandFromJson(Map<String, dynamic> json) =>
    AdmitPatientCommand(
      name: json['name'] as String?,
      nationalId: json['nationalId'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      country: json['country'] as String?,
      bloodType: $enumDecodeNullable(_$BloodTypeEnumMap, json['bloodType']),
      diagnosisSummary: json['diagnosisSummary'] as String?,
      doctorId: json['doctorId'] as String?,
      initialDiagnosis: json['initialDiagnosis'] as String?,
      bedId: json['bedId'] as String?,
      roomId: json['roomId'] as String?,
    );

Map<String, dynamic> _$AdmitPatientCommandToJson(
  AdmitPatientCommand instance,
) => <String, dynamic>{
  'name': instance.name,
  'nationalId': instance.nationalId,
  'dateOfBirth': instance.dateOfBirth,
  'gender': _$GenderEnumMap[instance.gender],
  'email': instance.email,
  'phone': instance.phone,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'country': instance.country,
  'bloodType': _$BloodTypeEnumMap[instance.bloodType],
  'diagnosisSummary': instance.diagnosisSummary,
  'doctorId': instance.doctorId,
  'initialDiagnosis': instance.initialDiagnosis,
  'bedId': instance.bedId,
  'roomId': instance.roomId,
};

const _$GenderEnumMap = {Gender.value0: 0, Gender.value1: 1};

const _$BloodTypeEnumMap = {
  BloodType.aPositive: 0,
  BloodType.aNegative: 1,
  BloodType.bPositive: 2,
  BloodType.bNegative: 3,
  BloodType.abPositive: 4,
  BloodType.abNegative: 5,
  BloodType.oPositive: 6,
  BloodType.oNegative: 7,
  BloodType.unknown: 8,
};
