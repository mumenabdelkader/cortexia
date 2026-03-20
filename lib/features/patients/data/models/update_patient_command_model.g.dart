// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_patient_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePatientCommandModel _$UpdatePatientCommandModelFromJson(
  Map<String, dynamic> json,
) => UpdatePatientCommandModel(
  id: json['id'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  street: json['street'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  zipCode: json['zipCode'] as String?,
  diagnosisSummary: json['diagnosisSummary'] as String?,
  bloodType: $enumDecodeNullable(_$BloodTypeEnumMap, json['bloodType']),
  nationalId: json['nationalId'] as String?,
);

Map<String, dynamic> _$UpdatePatientCommandModelToJson(
  UpdatePatientCommandModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipCode': instance.zipCode,
  'diagnosisSummary': instance.diagnosisSummary,
  'bloodType': _$BloodTypeEnumMap[instance.bloodType],
  'nationalId': instance.nationalId,
};

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
