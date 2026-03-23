import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/features/patient/presentation/ui/patient_dashboard_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/custom_info_card.dart';
import 'package:cortexia/features/patients/data/models/get_all_patients_query_model.dart';
import 'package:cortexia/features/patients/data/models/patient_model.dart';
import 'package:cortexia/features/patients/presentation/controllers/patients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/patient/presentation/widgets/department_banner.dart';
import 'package:cortexia/features/patient/presentation/widgets/patient_card.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/patient/presentation/widgets/app_bar_trailing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PatientsCubit(GetIt.I.get())
        ..getPatients(query: GetAllPatientsQueryModel()),
      child: const _PatientListView(),
    );
  }
}

class _PatientListView extends StatelessWidget {
  const _PatientListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: "Patient List",
        subtitle: "Patients",
        trailing: const AppBarTrailing(),
      ),
      body: BlocConsumer<PatientsCubit, PatientsState>(
        listener: (context, state) {
          if (state is PatientsStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          // ── Derive patient list from state ─────────────────────────────
          final List<PatientModel> patients = [];
          if (state is PatientsStateSuccess &&
              state.operation == 'getPatients') {
            final raw = state.data;
            if (raw is List) {
              for (final item in raw) {
                if (item is Map<String, dynamic>) {
                  patients.add(PatientModel.fromJson(item));
                }
              }
            }
          }

          final isLoading = state is PatientsStateLoading;
          final totalCount = patients.length;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      // ── Search bar ──────────────────────────────────────
                      const CustomTextFormField(
                        hintText: "Search by name, ID, or diagnosis...",
                        prefixIcon: Icons.search,
                        fillColor: Colors.white70,
                      ),
                      const SizedBox(height: 16),

                      // ── Department Banner ───────────────────────────────
                      DepartmentBanner(
                        departmentName: "All Departments",
                        patientCount: totalCount,
                      ),
                      const SizedBox(height: 16),

                      // ── Stats Row ───────────────────────────────────────
                      Row(
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
                              value: "—",
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
                              value: "—",
                              icon: Icons.notifications_active_outlined,
                              themeColor: Colors.orange,
                              bgColor: const Color(0xFFFFF7ED),
                              isSmall: false,
                            ),
                          ),
                        ],
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
              else if (patients.isEmpty)
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
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final p = patients[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PatientDashboardScreen(
                              patientId: p.id ?? '',
                            ),
                          ),
                        ),
                        child: PatientCard(
                          name: p.name ?? '—',
                          patientId: p.fileNumber ?? p.id ?? '—',
                          status: 'Active',
                          diagnosis: '—',
                          admissionDate: p.dateOfBirth ?? '—',
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
