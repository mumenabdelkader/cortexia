// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_lab_order_command_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLabOrderCommandModel _$CreateLabOrderCommandModelFromJson(
  Map<String, dynamic> json,
) => CreateLabOrderCommandModel(
  admissionId: json['admissionId'] as String?,
  testName: json['testName'] as String?,
  orderDate: json['orderDate'] as String?,
  doctorId: json['doctorId'] as String?,
);

Map<String, dynamic> _$CreateLabOrderCommandModelToJson(
  CreateLabOrderCommandModel instance,
) => <String, dynamic>{
  'admissionId': instance.admissionId,
  'testName': instance.testName,
  'orderDate': instance.orderDate,
  'doctorId': instance.doctorId,
};
