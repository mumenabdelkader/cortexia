import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/patients/data/models/blood_type.dart';
import 'package:cortexia/features/patients/data/models/gender.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final Gender? gender;
  final PatientAddress? address;
  final String? fileNumber;
  final String? diagnosisSummary;
  final BloodType? bloodType;
  final int? age;
  final String? sex;

  const PatientModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.fileNumber,
    this.diagnosisSummary,
    this.bloodType,
    this.age,
    this.sex,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}

@JsonSerializable()
class PatientAddress {
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;

  const PatientAddress({
    this.street,
    this.city,
    this.state,
    this.zipCode,
  });

  factory PatientAddress.fromJson(Map<String, dynamic> json) =>
      _$PatientAddressFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAddressToJson(this);
}
