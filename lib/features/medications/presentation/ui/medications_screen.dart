import 'package:cortexia/features/medications/data/models/medication_response_model.dart';
import 'package:cortexia/features/medications/data/models/medication_route.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';
import 'package:cortexia/features/medications/presentation/controllers/medications_cubit.dart';
import 'package:cortexia/features/medications/presentation/widgets/medication_custom_card_container.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicationsScreen extends StatefulWidget {
  final String admissionId;
  final String doctorId;
  const MedicationsScreen({super.key, this.admissionId = 'ADM-7A21F7EF3C7D', this.doctorId = 'DOC-1436C0633BBD'});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MedicationsCubit>().getAdmissionsAdmissionidMedications(admissionid: widget.admissionId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Medications",
        subtitle: "John Anderson • PT-2026-1356",
      ),
      body: BlocConsumer<MedicationsCubit, MedicationsState>(
        listener: (context, state) {
          if (state is MedicationsStatePrescribed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Medication added successfully")),
            );
            context.read<MedicationsCubit>().getAdmissionsAdmissionidMedications(admissionid: widget.admissionId);
          } else if (state is MedicationsStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          List<MedicationResponseModel> medications = [];
          if (state is MedicationsStateLoaded) {
            medications = state.medications;
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildAddMedicationHeader(context, medications.length),
              const SizedBox(height: 20),
              if (state is MedicationsStateLoading && medications.isEmpty)
                const Center(child: CircularProgressIndicator())
              else if (medications.isEmpty)
                const Center(child: Text("No medications found"))
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medications.length,
                  itemBuilder: (context, index) {
                    final med = medications[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CustomCardContainer(
                        title: med.drugName ?? '',
                        subTitle: "${med.dose}${med.doseUnit} • ${med.route != null ? med.route.toString().split('.').last : ''} • ${med.frequency}x daily",
                        statusText: "Active",
                        isActive: true,
                        actionButtons: [
                          OutlinedButton(onPressed: () {}, child: const Text("Edit")),
                          OutlinedButton(onPressed: () {}, child: const Text("Discontinue")),
                        ],
                        child: Text(
                          "🕒 Schedule: Every ${24 ~/ (med.frequency ?? 1)} hours\nStarted: ${med.startDate?.split('T').first ?? ''}",
                          style: const TextStyle(color: Color(0xFF475569), fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddMedicationHeader(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$count", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00ACC1))),
              const Text("Active Medications", style: TextStyle(color: Color(0xFF64748B))),
            ],
          ),
          SizedBox(
            width: 120,
            child: CustomElevatedButton(
              text: "+ Add New",
              height: 40,
              onPressed: () => _showAddMedicationDialog(context), // فتح الديالوج
            ),
          ),
        ],
      ),
    );
  }

  // الديالوج الخاص بإضافة الدواء
  void _showAddMedicationDialog(BuildContext context) {
    DateTime? selectedStartDate;
    DateTime? selectedEndDate;
    final drugNameController = TextEditingController();
    final doseController = TextEditingController();
    final unitController = TextEditingController();
    final frequencyController = TextEditingController();
    final routeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<MedicationsCubit>(),
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
          title: const Text("Add New Medication"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: drugNameController,
                  decoration: const InputDecoration(labelText: "Drug Name (e.g. Amoxicillin)"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: doseController,
                        decoration: const InputDecoration(labelText: "Dose"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: unitController,
                        decoration: const InputDecoration(labelText: "Unit (mg/ml)"),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: frequencyController,
                  decoration: const InputDecoration(labelText: "Frequency (Times per day)"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: routeController,
                  decoration: const InputDecoration(labelText: "Route (e.g. 1 for PO)"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),

                // اختيار تاريخ البداية
                ListTile(
                  title: Text(selectedStartDate == null ? "Select Start Date" : "Start: ${DateFormat('yyyy-MM-dd').format(selectedStartDate!)}"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030));
                    if (picked != null) setState(() => selectedStartDate = picked);
                  },
                ),

                // اختيار تاريخ النهاية
                ListTile(
                  title: Text(selectedEndDate == null ? "Select End Date" : "End: ${DateFormat('yyyy-MM-dd').format(selectedEndDate!)}"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now().add(const Duration(days: 7)), firstDate: DateTime(2020), lastDate: DateTime(2030));
                    if (picked != null) setState(() => selectedEndDate = picked);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                final routeValue = int.tryParse(routeController.text) ?? 0;
                final command = PrescribeMedicationCommandModel(
                  admissionId: widget.admissionId,
                  doctorId: widget.doctorId,
                  drugName: drugNameController.text,
                  dose: int.tryParse(doseController.text),
                  doseUnit: unitController.text,
                  frequency: int.tryParse(frequencyController.text),
                  route: MedicationRoute.values.firstWhere(
                    (e) => e.index == routeValue,
                    orElse: () => MedicationRoute.value1,
                  ),
                  startDate: selectedStartDate?.toIso8601String(),
                  endDate: selectedEndDate?.toIso8601String(),
                );
                context.read<MedicationsCubit>().postAdmissionsAdmissionidMedications(
                      admissionid: widget.admissionId,
                      requestBody: command,
                    );
                Navigator.pop(dialogContext);
              },
              child: const Text("Save Medication"),
            ),
          ],
          ),
        ),
      ),
    );
  }
}