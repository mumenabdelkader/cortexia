import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboar_patient_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_action_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_active_medications.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_current_alerts.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_vital_signs.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart'; // تأكد من المسار الصحيح
import 'package:cortexia/core/widgets/custom_elevated_button.dart'; // تأكد من المسار الصحيح

import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
import 'package:cortexia/features/admission/data/models/active_admission_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PatientDashboardScreen extends StatelessWidget {
  final String? admissionId;
  const PatientDashboardScreen({super.key, this.admissionId});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdmissionCubit(GetIt.I.get())
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          DashboarPatientCard(
                            name: admission.name ?? 'Unknown',
                            id: admission.fileNumber ?? admission.patientId ?? 'N/A',
                            status: admission.status ?? "Active",
                            genderAge: admission.gender == 1 ? 'Male' : (admission.gender == 2 ? 'Female' : 'N/A'),
                            room: admission.roomId ?? "N/A",
                            admittedDate: formattedDate,
                            diagnosis: admission.diagnosisSummary ?? admission.initialDiagnosis ?? "N/A",
                            daysCount: "Active", // Or calculate difference based on admissionDate
                          ),
                          const SizedBox(height: 16),
                          DashboardCurrentAlerts(admissionId: admission.admissionId),
                          const SizedBox(height: 16),
                          DashboardVitalSigns(admissionId: admission.admissionId),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 20),

                          CustomElevatedButton(
                            text: "Chat With AI",
                            borderRadius: 15,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00D2FF), Color(0xFF00E5FF)],
                            ),
                            onPressed: () {
                                Navigator.of(context).pushNamed(
                                  arguments: {
                                    'admissionId': admission.admissionId,
                                    'patientName': admission.name,
                                  },
                                  Routes.chatbotScreen,
                                );
                            },
                          ),

                          const SizedBox(height: 20),
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
            SizedBox(width: 12),
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
            SizedBox(width: 12),
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
                icon: Icons.image_outlined,
                iconColor: Colors.purpleAccent,
              ),
            ),
            SizedBox(width: 12),
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
            SizedBox(width: 12),
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
                subTitle: "Examination findings",
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
