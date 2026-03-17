import 'package:json_annotation/json_annotation.dart';

part 'add_case_history_command_model.g.dart';

@JsonSerializable()
class AddCaseHistoryCommandModel {
  String? admissionId;
  String? complaint;
  String? presentIllness;
  String? chronicDisease;
  String? geneticDisease;
  String? maritalHistory;
  String? specialHabits;
  String? clinicalNotes;
  String? doctorId;

  AddCaseHistoryCommandModel({this.admissionId, this.complaint, this.presentIllness, this.chronicDisease, this.geneticDisease, this.maritalHistory, this.specialHabits, this.clinicalNotes, this.doctorId});

  factory AddCaseHistoryCommandModel.fromJson(Map<String, dynamic> json) => _$AddCaseHistoryCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCaseHistoryCommandModelToJson(this);
}
