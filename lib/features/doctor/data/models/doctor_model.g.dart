// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: json['id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  gender: (json['gender'] as num?)?.toInt(),
  address: json['address'] == null
      ? null
      : DoctorAddress.fromJson(json['address'] as Map<String, dynamic>),
  specialty: json['specialty'] as String?,
  shift: (json['shift'] as num?)?.toInt(),
  role: (json['role'] as num?)?.toInt(),
  department: json['department'] as String?,
  experienceYears: (json['experienceYears'] as num?)?.toInt(),
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'address': instance.address,
      'specialty': instance.specialty,
      'shift': instance.shift,
      'role': instance.role,
      'department': instance.department,
      'experienceYears': instance.experienceYears,
    };

DoctorAddress _$DoctorAddressFromJson(Map<String, dynamic> json) =>
    DoctorAddress(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
    );

Map<String, dynamic> _$DoctorAddressToJson(DoctorAddress instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
    };
