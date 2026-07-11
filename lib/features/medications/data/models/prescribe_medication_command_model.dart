import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/medications/data/models/medication_route.dart';

part 'prescribe_medication_command_model.g.dart';

@JsonSerializable()
class PrescribeMedicationCommandModel {
  String? admissionId;
  String? id;
  String? drugName;
  int? dose;
  String? doseUnit;
  int? frequency;
  MedicationRoute? route;
  String? startDate;
  String? endDate;
  String? doctorId;

  PrescribeMedicationCommandModel({this.admissionId, this.id, this.drugName, this.dose, this.doseUnit, this.frequency, this.route, this.startDate, this.endDate, this.doctorId});

  factory PrescribeMedicationCommandModel.fromJson(Map<String, dynamic> json) => _$PrescribeMedicationCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescribeMedicationCommandModelToJson(this);
}
