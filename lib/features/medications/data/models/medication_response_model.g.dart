// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicationResponseModel _$MedicationResponseModelFromJson(
  Map<String, dynamic> json,
) => MedicationResponseModel(
  id: json['id'] as String?,
  drugName: json['drugName'] as String?,
  dose: (json['dose'] as num?)?.toInt(),
  doseUnit: json['doseUnit'] as String?,
  frequency: (json['frequency'] as num?)?.toInt(),
  route: $enumDecodeNullable(_$MedicationRouteEnumMap, json['route']),
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  admissionId: json['admissionId'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$MedicationResponseModelToJson(
  MedicationResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'drugName': instance.drugName,
  'dose': instance.dose,
  'doseUnit': instance.doseUnit,
  'frequency': instance.frequency,
  'route': _$MedicationRouteEnumMap[instance.route],
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'admissionId': instance.admissionId,
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
