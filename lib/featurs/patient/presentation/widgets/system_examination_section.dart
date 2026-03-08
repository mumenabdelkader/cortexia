import 'package:flutter/material.dart';
import 'examination_section_card.dart'; // تأكد من استيراد الحاوية الكبرى
import 'examination_category_card.dart'; // تأكد من استيراد الكارت الصغير

class SystemExaminationSection extends StatelessWidget {
  const SystemExaminationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // هنا ننادي على الحاوية المشتركة ونعطيها البيانات الخاصة بهذا القسم
    return const ExaminationSectionCard(
      title: "System Examination",
      icon: Icons.medical_services_outlined,
      iconColor: Color(0xFF0D9488), // لون Teal كما في التصميم
      child: Column(
        children: [
          // نضع هنا قائمة الـ CategoryCards المطلوبة
          ExaminationCategoryCard(
            title: "General Appearance",
            icon: Icons.person_outline,
            iconColor: Colors.green,
          ),
          ExaminationCategoryCard(
            title: "Eyes (HEENT)",
            icon: Icons.visibility_outlined,
            iconColor: Colors.blue,
            content: "PERRLA, conjunctiva clear",
          ),
          ExaminationCategoryCard(
            title: "Cardiovascular",
            icon: Icons.favorite_border,
            iconColor: Colors.red,
          ),
          ExaminationCategoryCard(
            title: "Respiratory",
            icon: Icons.air_outlined,
            iconColor: Colors.cyan,
          ),
          ExaminationCategoryCard(
            title: "Abdomen",
            icon: Icons.health_and_safety_outlined,
            iconColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}