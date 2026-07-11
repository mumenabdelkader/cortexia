// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabOrderModel _$LabOrderModelFromJson(Map<String, dynamic> json) =>
    LabOrderModel(
      id: json['id'] as String?,
      testName: json['testName'] as String?,
      orderDate: json['orderDate'] as String?,
      admissionId: json['admissionId'] as String?,
      doctorId: json['doctorId'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => LabResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LabOrderModelToJson(LabOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'testName': instance.testName,
      'orderDate': instance.orderDate,
      'admissionId': instance.admissionId,
      'doctorId': instance.doctorId,
      'results': instance.results,
    };
