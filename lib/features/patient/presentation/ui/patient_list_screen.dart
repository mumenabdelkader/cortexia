import 'package:cortexia/features/patient/presentation/ui/patient_dashboard_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/custom_info_card.dart';
import 'package:cortexia/features/admission/data/models/active_admission_model.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
import 'package:cortexia/core/services/room_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/patient/presentation/widgets/department_banner.dart';
import 'package:cortexia/features/patient/presentation/widgets/patient_card.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/patient/presentation/widgets/app_bar_trailing.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_cubit.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_state.dart';
import 'package:cortexia/features/alerts/data/models/alert_severity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warm the room cache as soon as the screen opens
    GetIt.I.get<RoomCacheService>().ensureLoaded();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AdmissionCubit(GetIt.I.get())
            ..getActiveAdmissions(),
        ),
        BlocProvider(
          create: (_) => AlertsCubit(GetIt.I.get())
            ..getActiveAlerts(null),
        ),
      ],
      child: const _PatientListView(),
    );
  }
}

class _PatientListView extends StatefulWidget {
  const _PatientListView();

  @override
  State<_PatientListView> createState() => _PatientListViewState();
}

class _PatientListViewState extends State<_PatientListView> {
  String _searchQuery = '';
  String _selectedStatus = 'All';

  Widget _buildFilterChip(String label, IconData icon, {Color? color}) {
    final isSelected = _selectedStatus == label;
    final themeColor = color ?? AppColors.primaryBlue;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? themeColor : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? themeColor : AppColors.border.withValues(alpha: 0.8),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: themeColor.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.01),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : (color ?? AppColors.textSecondary),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textMain,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: "Patient List",
        subtitle: "Monitoring dashboard",
        trailing: const AppBarTrailing(),
      ),
      body: BlocConsumer<AdmissionCubit, AdmissionState>(
        listener: (context, state) {
          if (state is AdmissionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final List<ActiveAdmissionModel> allPatients = [];
          if (state is ActiveAdmissionsLoaded) {
            allPatients.addAll(state.admissions);
          }

          // Filter patients by both query and chosen status tab
          final List<ActiveAdmissionModel> filteredPatients = allPatients.where((p) {
            final query = _searchQuery.toLowerCase();
            final name = (p.name ?? '').toLowerCase();
            final id = (p.fileNumber ?? p.patientId ?? '').toLowerCase();
            final diagnosis = (p.diagnosisSummary ?? p.initialDiagnosis ?? '').toLowerCase();
            final matchesQuery = _searchQuery.isEmpty ||
                name.contains(query) ||
                id.contains(query) ||
                diagnosis.contains(query);

            final statusStr = (p.status ?? 'Active').toLowerCase();
            bool matchesStatus = true;
            if (_selectedStatus == 'Critical') {
              matchesStatus = statusStr == 'critical';
            } else if (_selectedStatus == 'Stable') {
              matchesStatus = statusStr == 'stable';
            } else if (_selectedStatus == 'Active') {
              matchesStatus = statusStr == 'active';
            }

            return matchesQuery && matchesStatus;
          }).toList();

          final isLoading = state is AdmissionLoading;
          final totalCount = filteredPatients.length;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<AdmissionCubit>().getActiveAdmissions();
              context.read<AlertsCubit>().getActiveAlerts(null);
              GetIt.I.get<RoomCacheService>().refresh();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Search bar ──────────────────────────────────────
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CustomTextFormField(
                            hintText: "Search by name, ID, or diagnosis...",
                            prefixIcon: Icons.search,
                            fillColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value ?? '';
                              });
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Filter Tabs ─────────────────────────────────────
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              _buildFilterChip('All', Icons.dashboard_outlined),
                              const SizedBox(width: 8),
                              _buildFilterChip('Critical', Icons.report_problem_outlined, color: AppColors.errorRed),
                              const SizedBox(width: 8),
                              _buildFilterChip('Stable', Icons.check_circle_outline, color: AppColors.successGreen),
                              const SizedBox(width: 8),
                              _buildFilterChip('Active', Icons.pending_actions, color: AppColors.primaryBlue),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Department Banner ───────────────────────────────
                        DepartmentBanner(
                          departmentName: _selectedStatus == 'All'
                              ? "All Departments"
                              : "$_selectedStatus Patients",
                          patientCount: totalCount,
                        ),
                        const SizedBox(height: 16),

                        // ── Stats Row ───────────────────────────────────────
                        BlocBuilder<AlertsCubit, AlertsState>(
                          builder: (context, alertsState) {
                            int criticalCases = 0;
                            int activeAlertsCount = 0;

                            if (alertsState is AlertsLoaded) {
                              activeAlertsCount = alertsState.activeAlerts.length;
                              criticalCases = alertsState.activeAlerts.where((a) => a.severity == AlertSeverity.critical).length;
                            } else if (context.read<AlertsCubit>().activeAlerts.isNotEmpty) {
                              final alerts = context.read<AlertsCubit>().activeAlerts;
                              activeAlertsCount = alerts.length;
                              criticalCases = alerts.where((a) => a.severity == AlertSeverity.critical).length;
                            }

                            String criticalStr = (alertsState is AlertsLoading && activeAlertsCount == 0) ? "—" : "$criticalCases";
                            String activeAlertsStr = (alertsState is AlertsLoading && activeAlertsCount == 0) ? "—" : "$activeAlertsCount";

                            return Row(
                              children: [
                                Expanded(
                                  child: CustomInfoCard(
                                    title: "Total Patients",
                                    value: "$totalCount",
                                    icon: Icons.people_alt_outlined,
                                    themeColor: AppColors.primaryBlue,
                                    bgColor: AppColors.infoBg,
                                    isSmall: false,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: CustomInfoCard(
                                    title: "Critical Cases",
                                    value: criticalStr,
                                    icon: Icons.report_problem_outlined,
                                    themeColor: AppColors.errorRed,
                                    bgColor: AppColors.errorBg,
                                    isSmall: false,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: CustomInfoCard(
                                    title: "Active Alerts",
                                    value: activeAlertsStr,
                                    icon: Icons.notifications_active_outlined,
                                    themeColor: AppColors.warningOrange,
                                    bgColor: AppColors.warningBg,
                                    isSmall: false,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // ── Patient List ────────────────────────────────────────────
                if (isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                else if (filteredPatients.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: AppColors.textSecondary.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No patients found matching the criteria.",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        final p = filteredPatients[index];
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PatientDashboardScreen(
                                admissionId: p.admissionId ?? '',
                              ),
                            ),
                          ),
                          child: () {
                            final roomCache =
                                GetIt.I.get<RoomCacheService>();
                            final loc = roomCache.resolveLocation(
                              roomId: p.roomId,
                              bedId: p.bedId,
                            );
                            return PatientCard(
                              name: p.name ?? '—',
                              patientId:
                                  p.fileNumber ?? p.patientId ?? '—',
                              status: p.status ?? 'Active',
                              diagnosis: p.diagnosisSummary ??
                                  p.initialDiagnosis ??
                                  '—',
                              age: p.age?.toString(),
                              gender: p.gender == 1
                                  ? 'Male'
                                  : (p.gender == 2 ? 'Female' : '—'),
                              bloodType: p.bloodType != null
                                  ? 'Type ${p.bloodType}'
                                  : null,
                              floor: loc.floor,
                              roomNumber: loc.roomNumber,
                              bedNumber: loc.bedNumber,
                              roomType: loc.roomType,
                              hrValue: p.latestVitalSigns?.heartRate !=
                                      null
                                  ? "${p.latestVitalSigns!.heartRate} bpm"
                                  : "—",
                              tempValue: p.latestVitalSigns?.temperature !=
                                      null
                                  ? "${p.latestVitalSigns!.temperature}°C"
                                  : "—",
                              bpValue: (p.latestVitalSigns?.bpSystolic !=
                                          null &&
                                      p.latestVitalSigns?.bpDiastolic !=
                                          null)
                                  ? "${p.latestVitalSigns!.bpSystolic}/${p.latestVitalSigns!.bpDiastolic}"
                                  : "—",
                              spo2Value: p.latestVitalSigns?.pulseOxy !=
                                      null
                                  ? "${p.latestVitalSigns!.pulseOxy}%"
                                  : "—",
                            );
                          }(),
                        );
                      },
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}