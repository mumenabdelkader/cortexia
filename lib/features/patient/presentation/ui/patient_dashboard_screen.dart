import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/features/patient/presentation/ui/chatbot_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboar_patient_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_action_card.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_active_medications.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_current_alerts.dart';
import 'package:cortexia/features/patient/presentation/widgets/dashboard_vital_signs.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart'; // تأكد من المسار الصحيح
import 'package:cortexia/core/widgets/custom_elevated_button.dart'; // تأكد من المسار الصحيح

import 'package:cortexia/features/patients/data/models/patient_details_response_model.dart';
import 'package:cortexia/features/patients/presentation/controllers/patients_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PatientDashboardScreen extends StatelessWidget {
  final String? patientId;
  const PatientDashboardScreen({super.key, this.patientId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PatientsCubit(GetIt.I.get())
            ..getPatientsIdDetails(id: patientId ?? ""),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: const CustomAppBar(
          title: "Patient Dashboard",
          subtitle: "Medical Overview",
        ),
        body: patientId == null || patientId!.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_search, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "No Patient Selected",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please select a patient from the list.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            : BlocBuilder<PatientsCubit, PatientsState>(
                builder: (context, state) {
                  if (state is PatientsStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PatientsStateError) {
                    return Center(child: Text(state.message));
                  } else if (state is PatientsStateSuccess &&
                      state.operation == 'getPatientsIdDetails') {
                    final patient = state.data as PatientDetailsResponseModel;

                    // تجهيز البيانات للـ Card
                    final admission =
                        (patient.admissions != null &&
                            patient.admissions!.isNotEmpty)
                        ? patient.admissions!.first
                        : null;

                    String formattedDate = "N/A";
                    if (admission?.admissionDate != null) {
                      try {
                        DateTime dt = DateTime.parse(admission!.admissionDate!);
                        formattedDate = DateFormat('MMM dd, yyyy').format(dt);
                      } catch (_) {}
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          DashboarPatientCard(
                            name: patient.name,
                            id: patient.fileNumber ?? patient.id,
                            status:
                                "Active", // أو حسب الـ status في الـ admission
                            genderAge: patient.gender ?? 'N/A',
                            room: admission?.roomId ?? "N/A",
                            admittedDate: formattedDate,
                            diagnosis:
                                patient.diagnosisSummary ??
                                admission?.initialDiagnosis ??
                                "N/A",
                            daysCount:
                                "Calculating...", // يمكن حسابه من فرق التواريخ
                          ),
                          const SizedBox(height: 16),
                          const DashboardCurrentAlerts(),
                          const SizedBox(height: 16),
                          const DashboardVitalSigns(),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.medicationScreen,
                                arguments: {'admissionId': admission?.id},
                              );
                            },
                            child: DashboardActiveMedications(
                              admissionId: admission?.id,
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatbotScreen(),
                                ),
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
                  arguments: {'admissionId': admission?.id},
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
                  arguments: {'admissionId': admission?.id},
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
                  if (admission?.id != null && admission!.id!.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      Routes.medicalHistoryScreen,
                      arguments: {'admissionId': admission.id},
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
                  arguments: {'admissionId': admission?.id},
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
                  arguments: {'admissionId': admission?.id},
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
                  arguments: {'admissionId': admission?.id},
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
                  arguments: {'admissionId': admission?.id},
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
                  arguments: {'admissionId': admission?.id},
                ),
                title: "Interventions",
                subTitle: "Log procedures",
                icon: Icons.medical_services_outlined,
                iconColor: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
