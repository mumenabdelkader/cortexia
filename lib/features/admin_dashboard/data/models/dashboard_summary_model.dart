import 'package:json_annotation/json_annotation.dart';

part 'dashboard_summary_model.g.dart';

@JsonSerializable()
class DashboardSummaryModel {
  final int highRiskAlertsCount;
  final int totalRAGQueriesToday;
  final List<SystemActivityModel> recentSystemActivities;
  final HospitalStatsModel hospitalStats;

  const DashboardSummaryModel({
    required this.highRiskAlertsCount,
    required this.totalRAGQueriesToday,
    required this.recentSystemActivities,
    required this.hospitalStats,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardSummaryModelToJson(this);
}

@JsonSerializable()
class HospitalStatsModel {
  final int totalActivePatients;
  final int admissionsToday;
  final int dischargesToday;
  final double bedOccupancyPercentage;
  final int activeStaffOnShift;

  const HospitalStatsModel({
    required this.totalActivePatients,
    required this.admissionsToday,
    required this.dischargesToday,
    required this.bedOccupancyPercentage,
    required this.activeStaffOnShift,
  });

  factory HospitalStatsModel.fromJson(Map<String, dynamic> json) =>
      _$HospitalStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalStatsModelToJson(this);
}

@JsonSerializable()
class SystemActivityModel {
  final String action;
  final String? userId;
  final String timestamp;
  final String entityName;

  const SystemActivityModel({
    required this.action,
    this.userId,
    required this.timestamp,
    required this.entityName,
  });

  factory SystemActivityModel.fromJson(Map<String, dynamic> json) =>
      _$SystemActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemActivityModelToJson(this);
}
