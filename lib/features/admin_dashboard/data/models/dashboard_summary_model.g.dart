// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardSummaryModel _$DashboardSummaryModelFromJson(
  Map<String, dynamic> json,
) => DashboardSummaryModel(
  totalActivePatients: (json['totalActivePatients'] as num).toInt(),
  bedOccupancyPercentage: (json['bedOccupancyPercentage'] as num).toDouble(),
  highRiskAlertsCount: (json['highRiskAlertsCount'] as num).toInt(),
  totalRAGQueriesToday: (json['totalRAGQueriesToday'] as num).toInt(),
  recentSystemActivities: (json['recentSystemActivities'] as List<dynamic>)
      .map((e) => SystemActivityModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DashboardSummaryModelToJson(
  DashboardSummaryModel instance,
) => <String, dynamic>{
  'totalActivePatients': instance.totalActivePatients,
  'bedOccupancyPercentage': instance.bedOccupancyPercentage,
  'highRiskAlertsCount': instance.highRiskAlertsCount,
  'totalRAGQueriesToday': instance.totalRAGQueriesToday,
  'recentSystemActivities': instance.recentSystemActivities,
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
