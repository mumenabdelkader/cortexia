// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nursing_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NursingNoteModel _$NursingNoteModelFromJson(Map<String, dynamic> json) =>
    NursingNoteModel(
      id: json['id'] as String?,
      noteText: json['noteText'] as String?,
      noteDateTime: json['noteDateTime'] as String?,
      admissionId: json['admissionId'] as String?,
      nurseId: json['nurseId'] as String?,
      nurseName: json['nurseName'] as String?,
    );

Map<String, dynamic> _$NursingNoteModelToJson(NursingNoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'noteText': instance.noteText,
      'noteDateTime': instance.noteDateTime,
      'admissionId': instance.admissionId,
      'nurseId': instance.nurseId,
      'nurseName': instance.nurseName,
    };
