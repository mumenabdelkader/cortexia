// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_patient_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePatientCommandModel _$CreatePatientCommandModelFromJson(
  Map<String, dynamic> json,
) => CreatePatientCommandModel(
  name: json['name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  street: json['street'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  zipCode: json['zipCode'] as String?,
  fileNumber: json['fileNumber'] as String?,
  bloodType: $enumDecodeNullable(_$BloodTypeEnumMap, json['bloodType']),
  nationalId: json['nationalId'] as String?,
);

Map<String, dynamic> _$CreatePatientCommandModelToJson(
  CreatePatientCommandModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'dateOfBirth': instance.dateOfBirth,
  'gender': _$GenderEnumMap[instance.gender],
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipCode': instance.zipCode,
  'fileNumber': instance.fileNumber,
  'bloodType': _$BloodTypeEnumMap[instance.bloodType],
  'nationalId': instance.nationalId,
};

const _$GenderEnumMap = {Gender.value0: 0, Gender.value1: 1};

const _$BloodTypeEnumMap = {
  BloodType.value0: 0,
  BloodType.value1: 1,
  BloodType.value2: 2,
  BloodType.value3: 3,
  BloodType.value4: 4,
  BloodType.value5: 5,
  BloodType.value6: 6,
  BloodType.value7: 7,
  BloodType.value8: 8,
};
