import 'package:cortexia/features/patient/presentation/widgets/medication_custom_card_container.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Medications & Imaging",
        subtitle: "John Anderson • PT-2026-1356",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. كارت "إضافة دواء جديد"
          _buildAddMedicationHeader(),

          const SizedBox(height: 20),

          // 2. قائمة الأدوية (كل واحدة في CustomCardContainer)
          _buildMedicationItem(
            title: "Amoxicillin",
            subTitle: "500mg • PO • TID (3x daily)",
            details: "🕒 Schedule: 08:00, 14:00, 20:00\nIndication: Pneumonia\nStarted: Jan 28, 2026",
          ),

          const SizedBox(height: 16),

          _buildMedicationItem(
            title: "Metformin",
            subTitle: "850mg • PO • BID (2x daily)",
            details: "🕒 Schedule: 08:00, 20:00\nIndication: Type 2 Diabetes\nStarted: Long-term",
          ),
        ],
      ),
    );
  }

  // الجزء الخاص بـ "4 Active Medications"
  Widget _buildAddMedicationHeader() {
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("4", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00ACC1))),
              Text("Active Medications", style: TextStyle(color: Color(0xFF64748B))),
            ],
          ),
          SizedBox(
            width: 120,
            child: CustomElevatedButton(
              text: "+ Add New",
              height: 40,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  // ميثود بناء كارت دواء واحد باستخدام CustomCardContainer
  Widget _buildMedicationItem({required String title, required String subTitle, required String details}) {
    return CustomCardContainer(
      title: title,
      subTitle: subTitle,
      actionButtons: [
        Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Edit"))),
        const SizedBox(width: 12),
        Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Discontinue"))),
      ],
      child: Text(
        details,
        style: const TextStyle(color: Color(0xFF475569), fontSize: 14),
      ),
    );
  }
}