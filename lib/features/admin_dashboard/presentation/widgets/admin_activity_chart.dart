import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/dashboard_summary_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_dashboard_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AdminActivityChart extends StatelessWidget {
  const AdminActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Activity Trends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Activity volume over recent days',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Builder(
              builder: (context) {
                final state = context.watch<AdminDashboardCubit>().state;

                if (state is AdminDashboardLoading || state is AdminDashboardInitial) {
                  return const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryBlue));
                }

                if (state is AdminDashboardSuccess) {
                  final summary = state.data as DashboardSummaryModel;
                  final activities = summary.recentSystemActivities;

                  if (activities.isEmpty) {
                    return const Center(child: Text('No recent activity data'));
                  }

                  // Group by Date String (YYYY-MM-DD)
                  final Map<String, int> dailyCounts = {};
                  for (final activity in activities) {
                    try {
                      final dt = DateTime.parse(activity.timestamp);
                      final dateStr = DateFormat('yyyy-MM-dd').format(dt);
                      dailyCounts[dateStr] = (dailyCounts[dateStr] ?? 0) + 1;
                    } catch (_) {}
                  }

                  if (dailyCounts.isEmpty) {
                    return const Center(child: Text('Insufficient data to chart'));
                  }

                  // Sort dates chronologically
                  final sortedDates = dailyCounts.keys.toList()..sort();
                  
                  // Take last 7 days max for clean UI
                  final displayDates = sortedDates.length > 7
                      ? sortedDates.sublist(sortedDates.length - 7)
                      : sortedDates;

                  final List<FlSpot> spots = [];
                  double maxY = 0;
                  
                  for (int i = 0; i < displayDates.length; i++) {
                    final count = dailyCounts[displayDates[i]]!.toDouble();
                    if (count > maxY) maxY = count;
                    spots.add(FlSpot(i.toDouble(), count));
                  }

                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: maxY > 0 ? (maxY / 4).ceilToDouble() : 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: AppColors.divider,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final idx = value.toInt();
                              if (idx >= 0 && idx < displayDates.length) {
                                final dateStr = displayDates[idx];
                                final dt = DateTime.parse(dateStr);
                                final label = DateFormat('MMM d').format(dt);
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    label,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: maxY > 0 ? (maxY / 4).ceilToDouble() : 1,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) return const SizedBox.shrink();
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.right,
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: (displayDates.length - 1).toDouble(),
                      minY: 0,
                      maxY: maxY + (maxY * 0.2), // Add 20% headroom
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: AppColors.primaryBlue,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.primaryBlue.withValues(alpha: 0.1),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(child: Text('Failed to load data'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
