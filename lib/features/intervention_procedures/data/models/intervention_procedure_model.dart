import 'package:json_annotation/json_annotation.dart';
import 'package:cortexia/features/intervention_procedures/data/models/care_intervention_type.dart';

part 'intervention_procedure_model.g.dart';

@JsonSerializable()
class InterventionProcedureModel {
  final String? id;
  final CareInterventionType? type;
  final int? size;
  final String? insertionDate;
  final String? removalDate;
  final String? admissionId;
  final String? nurseId;

  InterventionProcedureModel({
    this.id,
    this.type,
    this.size,
    this.insertionDate,
    this.removalDate,
    this.admissionId,
    this.nurseId,
  });

  factory InterventionProcedureModel.fromJson(Map<String, dynamic> json) => _$InterventionProcedureModelFromJson(json);
  Map<String, dynamic> toJson() => _$InterventionProcedureModelToJson(this);
}
