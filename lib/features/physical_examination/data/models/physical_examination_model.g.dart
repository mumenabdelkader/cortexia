// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physical_examination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhysicalExaminationModel _$PhysicalExaminationModelFromJson(
  Map<String, dynamic> json,
) => PhysicalExaminationModel(
  id: json['id'] as String?,
  examDate: json['examDate'] as String?,
  temperature: (json['temperature'] as num?)?.toDouble(),
  bloodPressure: json['bloodPressure'] as String?,
  pulse: (json['pulse'] as num?)?.toInt(),
  respRate: (json['respRate'] as num?)?.toInt(),
  eyeStatus: json['eyeStatus'] as String?,
  skinStatus: json['skinStatus'] as String?,
  lipsStatus: json['lipsStatus'] as String?,
  heartExam: json['heartExam'] as String?,
  abdomenExam: json['abdomenExam'] as String?,
  localExamination: json['localExamination'] as String?,
  admissionId: json['admissionId'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$PhysicalExaminationModelToJson(
  PhysicalExaminationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'examDate': instance.examDate,
  'temperature': instance.temperature,
  'bloodPressure': instance.bloodPressure,
  'pulse': instance.pulse,
  'respRate': instance.respRate,
  'eyeStatus': instance.eyeStatus,
  'skinStatus': instance.skinStatus,
  'lipsStatus': instance.lipsStatus,
  'heartExam': instance.heartExam,
  'abdomenExam': instance.abdomenExam,
  'localExamination': instance.localExamination,
  'admissionId': instance.admissionId,
  'doctorId': instance.doctorId,
};
