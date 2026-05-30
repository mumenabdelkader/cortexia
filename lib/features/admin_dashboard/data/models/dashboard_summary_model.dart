import 'package:json_annotation/json_annotation.dart';

part 'dashboard_summary_model.g.dart';

@JsonSerializable()
class DashboardSummaryModel {
  final int totalActivePatients;
  final double bedOccupancyPercentage;
  final int highRiskAlertsCount;
  final int totalRAGQueriesToday;
  final List<SystemActivityModel> recentSystemActivities;

  const DashboardSummaryModel({
    required this.totalActivePatients,
    required this.bedOccupancyPercentage,
    required this.highRiskAlertsCount,
    required this.totalRAGQueriesToday,
    required this.recentSystemActivities,
  });

  factory DashboardSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardSummaryModelToJson(this);
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
