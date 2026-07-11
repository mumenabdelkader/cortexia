import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/patients/data/models/blood_type.dart';

part 'update_patient_command_model.g.dart';

@JsonSerializable()
class UpdatePatientCommandModel {
  String? id;
  String? phoneNumber;
  String? street;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? diagnosisSummary;
  BloodType? bloodType;
  String? nationalId;

  UpdatePatientCommandModel({this.id, this.phoneNumber, this.street, this.city, this.state, this.country, this.zipCode, this.diagnosisSummary, this.bloodType, this.nationalId});

  factory UpdatePatientCommandModel.fromJson(Map<String, dynamic> json) => _$UpdatePatientCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePatientCommandModelToJson(this);
}
