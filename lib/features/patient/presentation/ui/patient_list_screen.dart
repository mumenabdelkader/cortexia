import 'package:cortexia/features/patient/presentation/ui/patient_dashboard_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/custom_info_card.dart';
import 'package:cortexia/features/admission/data/models/active_admission_model.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
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

// 1. تحويل الكلاس إلى StatefulWidget
class _PatientListView extends StatefulWidget {
  const _PatientListView();

  @override
  State<_PatientListView> createState() => _PatientListViewState();
}

class _PatientListViewState extends State<_PatientListView> {
  // 2. متغير لحفظ نص البحث
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: "Patient List",
        subtitle: "Patients",
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
          // ── جلب كل المرضى من الـ state ─────────────────────────────
          final List<ActiveAdmissionModel> allPatients = [];
          if (state is ActiveAdmissionsLoaded) {
             allPatients.addAll(state.admissions);
          }

          // 3. فلترة المرضى بناءً على نص البحث
          final List<ActiveAdmissionModel> filteredPatients = allPatients.where((p) {
            if (_searchQuery.isEmpty) return true;

            final query = _searchQuery.toLowerCase();
            final name = (p.name ?? '').toLowerCase();
            final id = (p.fileNumber ?? p.patientId ?? '').toLowerCase();
            final diagnosis = (p.diagnosisSummary ?? p.initialDiagnosis ?? '').toLowerCase();

            return name.contains(query) || id.contains(query) || diagnosis.contains(query);
          }).toList();

          final isLoading = state is AdmissionLoading;
          final totalCount = filteredPatients.length; // عدد المرضى بعد الفلترة

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      // ── Search bar ──────────────────────────────────────
                      CustomTextFormField(
                        hintText: "Search by name, ID, or diagnosis...",
                        prefixIcon: Icons.search,
                        fillColor: Colors.white70,
                        // 4. إضافة دالة onChanged
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // ── Department Banner ───────────────────────────────
                      DepartmentBanner(
                        departmentName: "All Departments",
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
                              const SizedBox(width: 10),
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
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomInfoCard(
                                  title: "Active Alerts",
                                  value: activeAlertsStr,
                                  icon: Icons.notifications_active_outlined,
                                  themeColor: Colors.orange,
                                  bgColor: const Color(0xFFFFF7ED),
                                  isSmall: false,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // ── Patient List ────────────────────────────────────────────
              if (isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (filteredPatients.isEmpty) // استخدام القائمة المفلترة
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "No patients found.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.builder(
                    itemCount: filteredPatients.length, // استخدام القائمة المفلترة
                    itemBuilder: (context, index) {
                      final p = filteredPatients[index]; // استخدام القائمة المفلترة
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PatientDashboardScreen(
                              admissionId: p.admissionId ?? '',
                            ),
                          ),
                        ),
                        child: PatientCard(
                          name: p.name ?? '—',
                          patientId: p.fileNumber ?? p.patientId ?? '—',
                          status: p.status ?? 'Active',
                          diagnosis: p.diagnosisSummary ?? p.initialDiagnosis ?? '—',
                          age: p.age?.toString(),
                          gender: p.gender == 1 ? 'Male' : (p.gender == 2 ? 'Female' : '—'),
                          bloodType: p.bloodType != null ? 'Type ${p.bloodType}' : null, // Adjust if you have an enum mapping
                          phone: p.phone,
                          email: p.email,
                          hrValue: p.latestVitalSigns?.heartRate != null ? "${p.latestVitalSigns!.heartRate} bpm" : "—",
                          tempValue: p.latestVitalSigns?.temperature != null ? "${p.latestVitalSigns!.temperature}°C" : "—",
                          bpValue: (p.latestVitalSigns?.bpSystolic != null && p.latestVitalSigns?.bpDiastolic != null) ? "${p.latestVitalSigns!.bpSystolic}/${p.latestVitalSigns!.bpDiastolic}" : "—",
                          spo2Value: p.latestVitalSigns?.pulseOxy != null ? "${p.latestVitalSigns!.pulseOxy}%" : "—",
                        ),
                      );
                    },
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        },
      ),
    );
  }
}