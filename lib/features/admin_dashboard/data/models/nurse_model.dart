import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart'; // For DoctorAddress

part 'nurse_model.g.dart';

@JsonSerializable()
class NurseModel {
  final String? id;
  final String? name;
  final String? nationalId;
  final String? email;
  final String? phoneNumber;
  final String? dateOfBirth;
  final int? gender;
  final DoctorAddress? address;
  final int? shift;
  final int? role;
  final String? department;

  const NurseModel({
    this.id,
    this.name,
    this.nationalId,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.shift,
    this.role,
    this.department,
  });

  factory NurseModel.fromJson(Map<String, dynamic> json) =>
      _$NurseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NurseModelToJson(this);

  String get displayName => name != null ? 'Nurse $name' : 'Nurse';

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
      case 0: return 'Staff';
      case 1: return 'Head Nurse';
      default: return 'N/A';
    }
  }
}
