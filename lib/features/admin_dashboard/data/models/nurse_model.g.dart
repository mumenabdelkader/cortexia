// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nurse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NurseModel _$NurseModelFromJson(Map<String, dynamic> json) => NurseModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  nationalId: json['nationalId'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: (json['gender'] as num?)?.toInt(),
  address: json['address'] == null
      ? null
      : DoctorAddress.fromJson(json['address'] as Map<String, dynamic>),
  shift: (json['shift'] as num?)?.toInt(),
  role: (json['role'] as num?)?.toInt(),
  department: json['department'] as String?,
);

Map<String, dynamic> _$NurseModelToJson(NurseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nationalId': instance.nationalId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'address': instance.address,
      'shift': instance.shift,
      'role': instance.role,
      'department': instance.department,
    };
