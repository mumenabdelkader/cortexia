// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardSummaryModel _$DashboardSummaryModelFromJson(
  Map<String, dynamic> json,
) => DashboardSummaryModel(
  highRiskAlertsCount: (json['highRiskAlertsCount'] as num).toInt(),
  totalRAGQueriesToday: (json['totalRAGQueriesToday'] as num).toInt(),
  recentSystemActivities: (json['recentSystemActivities'] as List<dynamic>)
      .map((e) => SystemActivityModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  hospitalStats: HospitalStatsModel.fromJson(
    json['hospitalStats'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DashboardSummaryModelToJson(
  DashboardSummaryModel instance,
) => <String, dynamic>{
  'highRiskAlertsCount': instance.highRiskAlertsCount,
  'totalRAGQueriesToday': instance.totalRAGQueriesToday,
  'recentSystemActivities': instance.recentSystemActivities,
  'hospitalStats': instance.hospitalStats,
};

HospitalStatsModel _$HospitalStatsModelFromJson(Map<String, dynamic> json) =>
    HospitalStatsModel(
      totalActivePatients: (json['totalActivePatients'] as num).toInt(),
      admissionsToday: (json['admissionsToday'] as num).toInt(),
      dischargesToday: (json['dischargesToday'] as num).toInt(),
      bedOccupancyPercentage: (json['bedOccupancyPercentage'] as num)
          .toDouble(),
      activeStaffOnShift: (json['activeStaffOnShift'] as num).toInt(),
    );

Map<String, dynamic> _$HospitalStatsModelToJson(HospitalStatsModel instance) =>
    <String, dynamic>{
      'totalActivePatients': instance.totalActivePatients,
      'admissionsToday': instance.admissionsToday,
      'dischargesToday': instance.dischargesToday,
      'bedOccupancyPercentage': instance.bedOccupancyPercentage,
      'activeStaffOnShift': instance.activeStaffOnShift,
    };

SystemActivityModel _$SystemActivityModelFromJson(Map<String, dynamic> json) =>
    SystemActivityModel(
      action: json['action'] as String,
      userId: json['userId'] as String?,
      timestamp: json['timestamp'] as String,
      entityName: json['entityName'] as String,
    );

Map<String, dynamic> _$SystemActivityModelToJson(
  SystemActivityModel instance,
) => <String, dynamic>{
  'action': instance.action,
  'userId': instance.userId,
  'timestamp': instance.timestamp,
  'entityName': instance.entityName,
};
