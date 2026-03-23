import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/medications/data/models/medication_route.dart';

part 'medication_response_model.g.dart';

@JsonSerializable()
class MedicationResponseModel {
  final String? id;
  final String? drugName;
  final int? dose;
  final String? doseUnit;
  final int? frequency;
  final MedicationRoute? route;
  final String? startDate;
  final String? endDate;
  final String? admissionId;
  final String? doctorId;

  MedicationResponseModel({
    this.id,
    this.drugName,
    this.dose,
    this.doseUnit,
    this.frequency,
    this.route,
    this.startDate,
    this.endDate,
    this.admissionId,
    this.doctorId,
  });

  factory MedicationResponseModel.fromJson(Map<String, dynamic> json) => _$MedicationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicationResponseModelToJson(this);
}
