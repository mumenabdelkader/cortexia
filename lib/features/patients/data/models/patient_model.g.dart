// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  address: json['address'] == null
      ? null
      : PatientAddress.fromJson(json['address'] as Map<String, dynamic>),
  fileNumber: json['fileNumber'] as String?,
  diagnosisSummary: json['diagnosisSummary'] as String?,
  bloodType: $enumDecodeNullable(_$BloodTypeEnumMap, json['bloodType']),
  age: (json['age'] as num?)?.toInt(),
  sex: json['sex'] as String?,
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'gender': _$GenderEnumMap[instance.gender],
      'address': instance.address,
      'fileNumber': instance.fileNumber,
      'diagnosisSummary': instance.diagnosisSummary,
      'bloodType': _$BloodTypeEnumMap[instance.bloodType],
      'age': instance.age,
      'sex': instance.sex,
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

PatientAddress _$PatientAddressFromJson(Map<String, dynamic> json) =>
    PatientAddress(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
    );

Map<String, dynamic> _$PatientAddressToJson(PatientAddress instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
    };
