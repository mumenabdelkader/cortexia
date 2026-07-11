import 'package:json_annotation/json_annotation.dart';

part 'nursing_note_model.g.dart';

@JsonSerializable()
class NursingNoteModel {
  final String? id;
  final String? noteText;
  final String? noteDateTime;
  final String? admissionId;
  final String? nurseId;
  final String? nurseName;

  NursingNoteModel({
    this.id,
    this.noteText,
    this.noteDateTime,
    this.admissionId,
    this.nurseId,
    this.nurseName,
  });

  factory NursingNoteModel.fromJson(Map<String, dynamic> json) => _$NursingNoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NursingNoteModelToJson(this);
}
