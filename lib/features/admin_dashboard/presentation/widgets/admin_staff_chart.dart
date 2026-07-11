import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_doctors_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_nurses_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_users_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminStaffChart extends StatelessWidget {
  const AdminStaffChart({super.key});

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
            'Staff Distribution',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Active medical and administrative staff',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Builder(
              builder: (context) {
                final doctorsState = context.watch<AdminDoctorsCubit>().state;
                final nursesState = context.watch<AdminNursesCubit>().state;
                final usersState = context.watch<AdminUsersCubit>().state;

                if (doctorsState is AdminDoctorsLoading ||
                    nursesState is AdminNursesLoading ||
                    usersState is AdminUsersLoading) {
                  return const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryBlue));
                }

                int numDoctors = 0;
                int numNurses = 0;
                int numAdmins = 0;

                if (doctorsState is AdminDoctorsLoaded) {
                  numDoctors = doctorsState.doctors.length;
                }
                if (nursesState is AdminNursesLoaded) {
                  numNurses = nursesState.nurses.length;
                }
                if (usersState is AdminUsersSuccess && usersState.operation == kGetUsersWithRoles) {
                  final users = usersState.data as List<dynamic>;
                  numAdmins = users.where((u) => (u.roles as List).contains('Admin')).length;
                }

                if (numDoctors == 0 && numNurses == 0 && numAdmins == 0) {
                  return const Center(child: Text('No data available'));
                }

                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: [
                            if (numDoctors > 0)
                              PieChartSectionData(
                                color: AppColors.primaryBlue,
                                value: numDoctors.toDouble(),
                                title: '$numDoctors',
                                radius: 50,
                                titleStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            if (numNurses > 0)
                              PieChartSectionData(
                                color: AppColors.infoBlue,
                                value: numNurses.toDouble(),
                                title: '$numNurses',
                                radius: 50,
                                titleStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            if (numAdmins > 0)
                              PieChartSectionData(
                                color: AppColors.warningOrange,
                                value: numAdmins.toDouble(),
                                title: '$numAdmins',
                                radius: 50,
                                titleStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _indicator(AppColors.primaryBlue, 'Doctors'),
                          const SizedBox(height: 8),
                          _indicator(AppColors.infoBlue, 'Nurses'),
                          const SizedBox(height: 8),
                          _indicator(AppColors.warningOrange, 'Admins'),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textMain)),
      ],
    );
  }
}
