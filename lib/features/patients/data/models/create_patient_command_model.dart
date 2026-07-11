import 'package:cortexia/features/patients/data/models/gender.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/patients/data/models/blood_type.dart';

part 'create_patient_command_model.g.dart';

@JsonSerializable()
class CreatePatientCommandModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? dateOfBirth;
  Gender? gender;
  String? street;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? fileNumber;
  BloodType? bloodType;
  String? nationalId;

  CreatePatientCommandModel({this.name, this.email, this.phoneNumber, this.dateOfBirth, this.gender, this.street, this.city, this.state, this.country, this.zipCode, this.fileNumber, this.bloodType, this.nationalId});

  factory CreatePatientCommandModel.fromJson(Map<String, dynamic> json) => _$CreatePatientCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePatientCommandModelToJson(this);
}
