// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseHistoryModel _$CaseHistoryModelFromJson(Map<String, dynamic> json) =>
    CaseHistoryModel(
      id: json['id'] as String?,
      complaint: json['complaint'] as String?,
      presentIllness: json['presentIllness'] as String?,
      chronicDisease: json['chronicDisease'] as String?,
      geneticDisease: json['geneticDisease'] as String?,
      maritalHistory: json['maritalHistory'] as String?,
      specialHabits: json['specialHabits'] as String?,
      clinicalNotes: json['clinicalNotes'] as String?,
      admissionId: json['admissionId'] as String?,
      doctorId: json['doctorId'] as String?,
    );

Map<String, dynamic> _$CaseHistoryModelToJson(CaseHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'complaint': instance.complaint,
      'presentIllness': instance.presentIllness,
      'chronicDisease': instance.chronicDisease,
      'geneticDisease': instance.geneticDisease,
      'maritalHistory': instance.maritalHistory,
      'specialHabits': instance.specialHabits,
      'clinicalNotes': instance.clinicalNotes,
      'admissionId': instance.admissionId,
      'doctorId': instance.doctorId,
    };
