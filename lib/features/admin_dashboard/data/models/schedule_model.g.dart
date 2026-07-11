// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      id: json['id'] as String?,
      staffId: json['staffId'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'staffId': instance.staffId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'daysOfWeek': instance.daysOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
