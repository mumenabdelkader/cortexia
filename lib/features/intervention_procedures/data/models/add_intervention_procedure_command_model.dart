import 'package:cortexia/features/intervention_procedures/data/models/care_intervention_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_intervention_procedure_command_model.g.dart';

@JsonSerializable()
class AddInterventionProcedureCommandModel {
  String? id;
  CareInterventionType? type;
  int? size;
  String? insertionDate;
  String? removalDate;
  String? admissionId;
  String? nurseId;

  AddInterventionProcedureCommandModel({this.id, this.type, this.size, this.insertionDate, this.removalDate, this.admissionId, this.nurseId});

  factory AddInterventionProcedureCommandModel.fromJson(Map<String, dynamic> json) => _$AddInterventionProcedureCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddInterventionProcedureCommandModelToJson(this);
}
