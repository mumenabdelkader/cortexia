import 'package:cortexia/featurs/patient/presentation/widgets/medication_custom_card_container.dart';
import 'package:cortexia/featurs/patient/presentation/widgets/medication_summary_action_card.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Medications",
        subtitle: "John Anderson • PT-2026-1356",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. كارت ملخص الأدوية (SummaryActionCard)
          SummaryActionCard(
            count: "4",
            label: "Active Medications",
            buttonText: "+ Add New",
            themeColor: const Color(0xFF00ACC1),
            onAddTap: () {},
          ),

          const SizedBox(height: 20),

          // 2. كارت دواء (CustomCardContainer) مع حالة Active
          CustomCardContainer(
            title: "Amoxicillin",
            subTitle: "500mg • PO • TID (3x daily)",
            statusText: "Active", // النص اللي هيظهر في الـ Badge
            isActive: true,       // اللون هيتحول للأخضر تلقائياً
            actionButtons: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Edit"))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text("Discontinue"))),
            ],
            child: const Text(
              "🕒 Schedule: 08:00, 14:00, 20:00\nIndication: Pneumonia\nStarted: Jan 28, 2026",
              style: TextStyle(color: Color(0xFF475569), fontSize: 14),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}