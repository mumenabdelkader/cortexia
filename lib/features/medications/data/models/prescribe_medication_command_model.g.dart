// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescribe_medication_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescribeMedicationCommandModel _$PrescribeMedicationCommandModelFromJson(
  Map<String, dynamic> json,
) => PrescribeMedicationCommandModel(
  admissionId: json['admissionId'] as String?,
  id: json['id'] as String?,
  drugName: json['drugName'] as String?,
  dose: (json['dose'] as num?)?.toInt(),
  doseUnit: json['doseUnit'] as String?,
  frequency: (json['frequency'] as num?)?.toInt(),
  route: $enumDecodeNullable(_$MedicationRouteEnumMap, json['route']),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$PrescribeMedicationCommandModelToJson(
  PrescribeMedicationCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'id': instance.id,
  'drugName': instance.drugName,
  'dose': instance.dose,
  'doseUnit': instance.doseUnit,
  'frequency': instance.frequency,
  'route': _$MedicationRouteEnumMap[instance.route],
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'doctorId': instance.doctorId,
};

const _$MedicationRouteEnumMap = {
  MedicationRoute.oral: 0,
  MedicationRoute.iv: 1,
  MedicationRoute.im: 2,
  MedicationRoute.sc: 3,
  MedicationRoute.topical: 4,
  MedicationRoute.inhalation: 5,
  MedicationRoute.rectal: 6,
};
