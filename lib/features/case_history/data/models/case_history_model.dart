import 'package:json_annotation/json_annotation.dart';

part 'case_history_model.g.dart';

@JsonSerializable()
class CaseHistoryModel {
  final String? id;
  final String? complaint;
  final String? presentIllness;
  final String? chronicDisease;
  final String? geneticDisease;
  final String? maritalHistory;
  final String? specialHabits;
  final String? clinicalNotes;
  final String? admissionId;
  final String? doctorId;

  CaseHistoryModel({
    this.id,
    this.complaint,
    this.presentIllness,
    this.chronicDisease,
    this.geneticDisease,
    this.maritalHistory,
    this.specialHabits,
    this.clinicalNotes,
    this.admissionId,
    this.doctorId,
  });

  factory CaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$CaseHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaseHistoryModelToJson(this);
}
