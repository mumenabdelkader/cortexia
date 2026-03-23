import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/features/medications/presentation/controllers/medications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DashboardActiveMedications extends StatefulWidget {
  final String? admissionId;
  const DashboardActiveMedications({super.key, this.admissionId});

  @override
  State<DashboardActiveMedications> createState() => _DashboardActiveMedicationsState();
}

class _DashboardActiveMedicationsState extends State<DashboardActiveMedications> {
  @override
  Widget build(BuildContext context) {
    if (widget.admissionId == null || widget.admissionId!.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (context) => MedicationsCubit(GetIt.I.get())..getAdmissionsAdmissionidMedications(admissionid: widget.admissionId!),
      child: BlocBuilder<MedicationsCubit, MedicationsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان القسم مع أيقونة الكبسولة
                Row(
                  children: const [
                    Icon(Icons.medication_outlined, color: Colors.cyan, size: 22),
                    SizedBox(width: 8),
                    Text(
                      "Active Medications",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                if (state is MedicationsStateLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is MedicationsStateError)
                  Center(child: Text(state.message))
                else if (state is MedicationsStateLoaded)
                  ..._buildMedicationList(state.medications)
                else
                  const Center(child: Text("No active medications")),

                const SizedBox(height: 20),

                // زر العرض الكامل
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "View All Medications",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildMedicationList(List<dynamic> medications) {
    if (medications.isEmpty) {
      return [const Center(child: Text("No active medications"))];
    }

    // عرض أول 3 أدوية فقط في الداشبورد
    final displayList = medications.take(3).toList();

    return displayList.map((med) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildMedicationItem(
          name: med.drugName ?? 'Unknown',
          info: "${med.dose}${med.doseUnit} • ${med.route != null ? med.route.toString().split('.').last : ''}",
          time: med.frequency != null ? "${med.frequency}x" : "N/A",
        ),
      );
    }).toList();
  }

  // Widget فرعي لكل دواء
  Widget _buildMedicationItem({
    required String name,
    required String info,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF), // لون أزرق باهت جداً للخلفية
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                info,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          // كبسولة الوقت الصغير
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withValues(alpha:0.1)),
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}