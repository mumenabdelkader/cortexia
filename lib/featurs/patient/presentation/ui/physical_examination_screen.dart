import 'package:cortexia/featurs/patient/presentation/widgets/additional_notes_section.dart';
import 'package:cortexia/featurs/patient/presentation/widgets/neurological_examination_section.dart';
import 'package:cortexia/featurs/patient/presentation/widgets/system_examination_section.dart';
import 'package:cortexia/featurs/patient/presentation/widgets/vital_status_card.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart'; // استيراد الزرار الخاص بك


class PhysicalExaminationScreen extends StatelessWidget {
  const PhysicalExaminationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Physical Examination",
        subtitle: "John Anderson • PT-2026-1234",
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                _buildVitalSignsGrid(),
                const SizedBox(height: 24),
                const SystemExaminationSection(),
                const NeurologicalExaminationSection(),
                const AdditionalNotesSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // منطقة الزر السفلي باستخدام الكلاس الخاص بك
          _buildBottomAction(),
        ],
      ),
    );
  }

  // ميثود بناء شبكة العلامات الحيوية (Vital Signs)
  Widget _buildVitalSignsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Vital Signs",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: const [
            VitalStatusCard(label: "Temperature", value: "37.2", unit: "°C"),
            VitalStatusCard(label: "Blood Pressure", value: "120/80", unit: "mmHg"),
            VitalStatusCard(label: "Heart Rate", value: "82", unit: "bpm"),
            VitalStatusCard(label: "Respiratory Rate", value: "16", unit: "br/min"),
          ],
        ),
      ],
    );
  }

  // ميثود بناء منطقة الزر السفلي
  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: CustomElevatedButton(
        text: "Save Examination",
        borderRadius: 12.0, // جعل الحواف متناسقة مع كروت الصفحة
        onPressed: () {
          // هنا يتم استدعاء منطق الحفظ (Save Logic)
          print("Examination Saved!");
        },
      ),
    );
  }
}