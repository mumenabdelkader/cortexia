import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  final String? id;
  final String? staffId;
  final String? startDate;
  final String? endDate;
  final List<int>? daysOfWeek;
  final String? startTime;
  final String? endTime;

  const ScheduleModel({
    this.id,
    this.staffId,
    this.startDate,
    this.endDate,
    this.daysOfWeek,
    this.startTime,
    this.endTime,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
