// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_nursing_note_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNursingNoteCommandModel _$AddNursingNoteCommandModelFromJson(
  Map<String, dynamic> json,
) => AddNursingNoteCommandModel(
  admissionId: json['admissionId'] as String?,
  id: json['id'] as String?,
  noteText: json['noteText'] as String?,
  noteDateTime: json['noteDateTime'] as String?,
  nurseId: json['nurseId'] as String?,
);

Map<String, dynamic> _$AddNursingNoteCommandModelToJson(
  AddNursingNoteCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'id': instance.id,
  'noteText': instance.noteText,
  'noteDateTime': instance.noteDateTime,
  'nurseId': instance.nurseId,
};
