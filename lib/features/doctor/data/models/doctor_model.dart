import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final int? gender;
  final DoctorAddress? address;
  final String? specialty;
  final int? shift;
  final int? role;
  final String? department;
  final int? experienceYears;

  const DoctorModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.specialty,
    this.shift,
    this.role,
    this.department,
    this.experienceYears,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  String get displayName => name != null ? 'Dr. $name' : 'Doctor';

  String get genderLabel {
    switch (gender) {
      case 0: return 'Male';
      case 1: return 'Female';
      default: return 'N/A';
    }
  }

  String get shiftLabel {
    switch (shift) {
      case 0: return 'Morning';
      case 1: return 'Evening';
      case 2: return 'Night';
      default: return 'N/A';
    }
  }

  String get roleLabel {
    switch (role) {
      case 0: return 'Specialist';
      case 1: return 'Consultant';
      case 2: return 'Intern';
      default: return 'N/A';
    }
  }
}

@JsonSerializable()
class DoctorAddress {
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;

  const DoctorAddress({this.street, this.city, this.state, this.zipCode});

  factory DoctorAddress.fromJson(Map<String, dynamic> json) =>
      _$DoctorAddressFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAddressToJson(this);

  String get fullAddress =>
      [street, city, state].where((e) => e != null && e.isNotEmpty).join(', ');
}
