// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_case_history_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCaseHistoryCommandModel _$AddCaseHistoryCommandModelFromJson(
  Map<String, dynamic> json,
) => AddCaseHistoryCommandModel(
  admissionId: json['admissionId'] as String?,
  complaint: json['complaint'] as String?,
  presentIllness: json['presentIllness'] as String?,
  chronicDisease: json['chronicDisease'] as String?,
  geneticDisease: json['geneticDisease'] as String?,
  maritalHistory: json['maritalHistory'] as String?,
  specialHabits: json['specialHabits'] as String?,
  clinicalNotes: json['clinicalNotes'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$AddCaseHistoryCommandModelToJson(
  AddCaseHistoryCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'complaint': instance.complaint,
  'presentIllness': instance.presentIllness,
  'chronicDisease': instance.chronicDisease,
  'geneticDisease': instance.geneticDisease,
  'maritalHistory': instance.maritalHistory,
  'specialHabits': instance.specialHabits,
  'clinicalNotes': instance.clinicalNotes,
  'doctorId': instance.doctorId,
};
