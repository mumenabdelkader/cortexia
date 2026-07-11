import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/bed_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_rooms_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRoomsChart extends StatelessWidget {
  const AdminRoomsChart({super.key});

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
            'Bed Capacity per Floor',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Available vs Occupied Beds',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Builder(
              builder: (context) {
                final roomsState = context.watch<AdminRoomsCubit>().state;

                if (roomsState is AdminRoomsLoading || roomsState is AdminRoomsInitial) {
                  return const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryBlue));
                }

                if (roomsState is AdminRoomsError) {
                  return const Center(child: Text('Failed to load room data'));
                }

                if (roomsState is AdminRoomsLoaded) {
                  final rooms = roomsState.rooms;
                  if (rooms.isEmpty) return const Center(child: Text('No rooms available'));

                  // Map of Floor -> [Available, Occupied]
                  final Map<int, List<int>> floorData = {};

                  for (final room in rooms) {
                    final floor = room.floor ?? 0;
                    floorData.putIfAbsent(floor, () => [0, 0]);
                    
                    if (room.beds != null) {
                      for (final bed in room.beds!) {
                        if (bed.status == BedStatus.available) {
                          floorData[floor]![0]++;
                        } else {
                          floorData[floor]![1]++; // Occupied or Maintenance
                        }
                      }
                    }
                  }

                  final sortedFloors = floorData.keys.toList()..sort();

                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _getMaxY(floorData),
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index >= 0 && index < sortedFloors.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Fl ${sortedFloors[index]}',
                                    style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: sortedFloors.asMap().entries.map((entry) {
                        final index = entry.key;
                        final floor = entry.value;
                        final available = floorData[floor]![0].toDouble();
                        final occupied = floorData[floor]![1].toDouble();

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: available,
                              color: AppColors.successGreen,
                              width: 16,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                            BarChartRodData(
                              toY: occupied,
                              color: AppColors.errorRed,
                              width: 16,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }

                return const Center(child: Text('No data'));
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _indicator(AppColors.successGreen, 'Available'),
              const SizedBox(width: 16),
              _indicator(AppColors.errorRed, 'Occupied/Maint.'),
            ],
          )
        ],
      ),
    );
  }

  double _getMaxY(Map<int, List<int>> data) {
    double max = 0;
    for (var counts in data.values) {
      if (counts[0] > max) max = counts[0].toDouble();
      if (counts[1] > max) max = counts[1].toDouble();
    }
    return max + 5; // padding
  }

  Widget _indicator(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textMain)),
      ],
    );
  }
}
