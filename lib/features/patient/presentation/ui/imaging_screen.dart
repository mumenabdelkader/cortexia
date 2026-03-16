import 'package:cortexia/features/patient/presentation/widgets/medication_custom_card_container.dart';
import 'package:cortexia/features/patient/presentation/widgets/summary_action_card.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';

class ImagingScreen extends StatelessWidget {
  const ImagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Imaging",
        subtitle: "John Anderson • PT-2026-1356",
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. كارت ملخص الأدوية (SummaryActionCard)
          SummaryActionCard(
            count: "4",
            label: "Active Medications",
            buttonText: "+ Order Study",
            themeColor: Colors.blue,
            onAddTap: () {},
          ),

          const SizedBox(height: 20),
          // 3. كارت أشعة (CustomCardContainer) مع حالة Completed
          CustomCardContainer(
            title: "Chest X-Ray",
            subTitle: "Feb 2, 2026",
            statusText: "Completed", // النص اللي هيظهر في الـ Badge
            isActive: true,         // اللون هيتحول للرمادي/الأزرق الهادئ
            actionButtons: [
              TextButton(
                onPressed: () {},
                child: const Text("View Images →", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
            child: const Text(
              "Findings: Bilateral infiltrates consistent with pneumonia. No pleural effusion.",
              style: TextStyle(color: Color(0xFF475569), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}