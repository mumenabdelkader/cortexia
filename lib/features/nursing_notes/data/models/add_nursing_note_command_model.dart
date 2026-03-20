import 'package:json_annotation/json_annotation.dart';

part 'add_nursing_note_command_model.g.dart';

@JsonSerializable()
class AddNursingNoteCommandModel {
  String? admissionId;
  String? noteText;
  String? noteDateTime;
  String? nurseId;

  AddNursingNoteCommandModel({this.admissionId, this.noteText, this.noteDateTime, this.nurseId});

  factory AddNursingNoteCommandModel.fromJson(Map<String, dynamic> json) => _$AddNursingNoteCommandModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddNursingNoteCommandModelToJson(this);
}
