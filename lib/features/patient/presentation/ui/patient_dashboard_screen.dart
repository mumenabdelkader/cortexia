import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboar_patient_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_action_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_active_medications.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_current_alerts.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_vital_signs.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PatientDashboardScreen extends StatelessWidget {
  final String? admissionId;
  const PatientDashboardScreen({super.key, this.admissionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdmissionCubit(GetIt.I.get())
        ..getAdmissionById(admissionId ?? ""),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: const CustomAppBar(
          title: "Patient Dashboard",
          subtitle: "Medical Overview",
        ),
        body: admissionId == null || admissionId!.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_search, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "No Admission Selected",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please select an admission from the list.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : BlocBuilder<AdmissionCubit, AdmissionState>(
                builder: (context, state) {
                  if (state is AdmissionLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AdmissionError) {
                    return Center(child: Text(state.message));
                  } else if (state is AdmissionDetailsLoaded) {
                    final admission = state.admission;

                    String formattedDate = "N/A";
                    if (admission.admissionDate != null) {
                      try {
                        DateTime dt = DateTime.parse(admission.admissionDate!);
                        formattedDate = DateFormat('MMM dd, yyyy').format(dt);
                      } catch (_) {}
                    }

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader("Patient Details", Icons.badge_outlined),
                          const SizedBox(height: 10),
                          DashboarPatientCard(
                            name: admission.name ?? 'Unknown',
                            id: admission.fileNumber ?? admission.patientId ?? 'N/A',
                            status: admission.status ?? "Active",
                            genderAge: admission.gender == 1 ? 'Male' : (admission.gender == 2 ? 'Female' : 'N/A'),
                            room: admission.roomId ?? "N/A",
                            admittedDate: formattedDate,
                            diagnosis: admission.diagnosisSummary ?? admission.initialDiagnosis ?? "N/A",
                            daysCount: "Active",
                          ),
                          const SizedBox(height: 24),

                          // ── AI Assistant Callout ─────────────────────────
                          _buildAiChatCallout(context, admission),
                          const SizedBox(height: 24),

                          _buildSectionHeader("Vitals & Alerts", Icons.favorite_border_rounded),
                          const SizedBox(height: 10),
                          DashboardCurrentAlerts(admissionId: admission.admissionId),
                          const SizedBox(height: 14),
                          DashboardVitalSigns(admissionId: admission.admissionId),
                          const SizedBox(height: 24),

                          _buildSectionHeader("Medications", Icons.medication_outlined),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.medicationScreen,
                                arguments: {'admissionId': admission.admissionId},
                              );
                            },
                            child: DashboardActiveMedications(
                              admissionId: admission.admissionId,
                            ),
                          ),
                          const SizedBox(height: 24),

                          _buildSectionHeader("Quick Medical Actions", Icons.grid_view_rounded),
                          const SizedBox(height: 12),
                          _buildActionGrid(context, admission),
                          const SizedBox(height: 30),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text("No Data"));
                },
              ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryBlue),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildAiChatCallout(BuildContext context, dynamic admission) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0052D4),
            Color(0xFF4364F7),
            Color(0xFF6FB1FC),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4364F7).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.chatbotScreen,
              arguments: {
                'admissionId': admission.admissionId,
                'patientName': admission.name,
              },
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Clinical AI Assistant",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Ask questions, summarize records, or get diagnostic help instantly.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context, dynamic admission) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.clinicalNotesScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Clinical Notes",
                subTitle: "View timeline",
                icon: Icons.description_outlined,
                iconColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.labResultsScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Lab Results",
                subTitle: "Check reports",
                icon: Icons.analytics_outlined,
                iconColor: Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardActionCard(
                onPressed: () {
                  if (admission?.admissionId != null && admission!.admissionId!.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      Routes.medicalHistoryScreen,
                      arguments: {'admissionId': admission.admissionId},
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'No active admission found for this patient.',
                        ),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                title: "Medical History",
                subTitle: "View records",
                icon: Icons.assignment_outlined,
                iconColor: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.fluidBalanceScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Fluid Balance",
                subTitle: "I/O tracking",
                icon: Icons.water_drop_outlined,
                iconColor: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.medicationScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Medication",
                subTitle: "View records",
                icon: Icons.medication_outlined,
                iconColor: Colors.purpleAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.imagingScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Imaging",
                subTitle: "Radiology & Scans",
                icon: Icons.image_outlined,
                iconColor: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.vitalSignsScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Vital Signs",
                subTitle: "Record vitals",
                icon: Icons.monitor_heart_outlined,
                iconColor: Colors.pinkAccent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.interventionProceduresScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Interventions",
                subTitle: "Log procedures",
                icon: Icons.medical_services_outlined,
                iconColor: Colors.deepOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardActionCard(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.physicalExaminationScreen,
                  arguments: {'admissionId': admission?.admissionId},
                ),
                title: "Physical Exam",
                subTitle: "Findings",
                icon: Icons.personal_injury_outlined,
                iconColor: Colors.indigo,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}
