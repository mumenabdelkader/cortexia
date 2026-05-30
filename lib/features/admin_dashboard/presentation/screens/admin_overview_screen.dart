import 'package:cortexia/core/responsive/responsive.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/dashboard_summary_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_dashboard_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_activity_tile.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_stat_card.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_rooms_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_doctors_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_nurses_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_users_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_staff_chart.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_rooms_chart.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_activity_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOverviewScreen extends StatefulWidget {
  const AdminOverviewScreen({super.key});

  @override
  State<AdminOverviewScreen> createState() => _AdminOverviewScreenState();
}

class _AdminOverviewScreenState extends State<AdminOverviewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminDashboardCubit>().getSummary();
    context.read<AdminRoomsCubit>().getRooms();
    context.read<AdminDoctorsCubit>().getDoctors();
    context.read<AdminNursesCubit>().getNurses();
    context.read<AdminUsersCubit>().getUsersWithRoles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        if (state is AdminDashboardLoading || state is AdminDashboardInitial) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }
        if (state is AdminDashboardError) {
          return _buildError(state.message);
        }
        if (state is AdminDashboardSuccess) {
          final summary = state.data as DashboardSummaryModel;
          return _buildContent(summary);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(DashboardSummaryModel summary) {
    int crossAxisCount = 4;
    double aspectRatio = 1.4;

    if (context.isDesktop) {
      crossAxisCount = 4;
      aspectRatio = 1.4;
    } else if (context.isTablet || context.isLargeTablet) {
      crossAxisCount = 2;
      aspectRatio = 1.3;
    } else if (context.isMobileLarge) {
      crossAxisCount = 2;
      aspectRatio = 1.1;
    } else {
      crossAxisCount = 1;
      aspectRatio = 2.2;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome header
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Real-time system metrics and recent activity',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),

          // Stat cards grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: aspectRatio,
            children: [
              AdminStatCard(
                title: 'Active Patients',
                value: '${summary.totalActivePatients}',
                icon: Icons.person_outline,
                accentColor: AppColors.primaryBlue,
                subtitle: 'Currently admitted',
              ),
              AdminStatCard(
                title: 'Bed Occupancy',
                value:
                    '${summary.bedOccupancyPercentage.toStringAsFixed(1)}%',
                icon: Icons.bed_outlined,
                accentColor: AppColors.warningOrange,
                subtitle: 'Of total beds in use',
              ),
              AdminStatCard(
                title: 'High Risk Alerts',
                value: '${summary.highRiskAlertsCount}',
                icon: Icons.warning_amber_outlined,
                accentColor: AppColors.errorRed,
                subtitle: 'Require immediate attention',
              ),
              AdminStatCard(
                title: 'RAG Queries Today',
                value: '${summary.totalRAGQueriesToday}',
                icon: Icons.psychology_outlined,
                accentColor: AppColors.successGreen,
                subtitle: 'AI assistant queries',
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Middle row: Charts
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(height: 350, child: const AdminStaffChart()),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: SizedBox(height: 350, child: const AdminRoomsChart()),
                ),
              ],
            )
          else
            Column(
              children: [
                SizedBox(height: 350, child: const AdminStaffChart()),
                const SizedBox(height: 24),
                SizedBox(height: 350, child: const AdminRoomsChart()),
              ],
            ),
          
          const SizedBox(height: 32),

          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(height: 400, child: const AdminActivityChart()),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: _buildRecentActivityList(summary),
                ),
              ],
            )
          else
            Column(
              children: [
                SizedBox(height: 400, child: const AdminActivityChart()),
                const SizedBox(height: 32),
                _buildRecentActivityList(summary),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityList(DashboardSummaryModel summary) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: AdminSectionHeader(
              title: 'Recent Activity Logs',
              subtitle: '${summary.recentSystemActivities.length} latest events',
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          if (summary.recentSystemActivities.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'No recent activities',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: summary.recentSystemActivities.length,
              itemBuilder: (_, i) => AdminActivityTile(
                activity: summary.recentSystemActivities[i],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () =>
                context.read<AdminDashboardCubit>().getSummary(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
