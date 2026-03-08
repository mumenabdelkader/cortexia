import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'examination_section_card.dart';

class NeurologicalExaminationSection extends StatelessWidget {
  const NeurologicalExaminationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExaminationSectionCard(
      title: "Neurological Examination",
      // يمكنك إضافة أيقونة إذا أردت مثل Icons.psychology_outlined
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Glasgow Coma Scale (GCS)",
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // صف مربعات الـ GCS (Eye, Verbal, Motor)
          Row(
            children: [
              _buildGCSBox("Eye", "4"),
              const SizedBox(width: 12),
              _buildGCSBox("Verbal", "5"),
              const SizedBox(width: 12),
              _buildGCSBox("Motor", "6"),
            ],
          ),

          const SizedBox(height: 12),

          // شريط عرض المجموع الكلي
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4), // خلفية خضراء باهتة جداً
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Total GCS: 15/15",
                style: TextStyle(
                  color: Color(0xFF166534),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // استخدام CustomTextFormField الموحد الخاص بك
          const CustomTextFormField(
            labelText: "Pupil Response",
            hintText: "Describe pupil response...",
          ),

          const SizedBox(height: 16),

          const CustomTextFormField(
            labelText: "Motor Function",
            hintText: "Describe motor function...",
          ),
        ],
      ),
    );
  }

  // ميثود مساعدة لبناء مربعات الـ GCS الصغيرة
  Widget _buildGCSBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}