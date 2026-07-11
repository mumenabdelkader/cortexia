import 'package:flutter/material.dart';
import 'examination_section_card.dart';
import 'examination_category_card.dart';

class SystemExaminationSection extends StatelessWidget {
  final TextEditingController? generalApperanceController;
  final TextEditingController? eyeController;
  final TextEditingController? heartController;
  final TextEditingController? respController;
  final TextEditingController? abdomenController;

  const SystemExaminationSection({
    super.key,
    this.generalApperanceController,
    this.eyeController,
    this.heartController,
    this.respController,
    this.abdomenController,
  });

  @override
  Widget build(BuildContext context) {
    return ExaminationSectionCard(
      title: "System Examination",
      icon: Icons.medical_services_outlined,
      iconColor: const Color(0xFF0D9488),
      child: Column(
        children: [
          ExaminationCategoryCard(
            title: "General Appearance",
            icon: Icons.person_outline,
            iconColor: Colors.green,
            controller: generalApperanceController,
          ),
          ExaminationCategoryCard(
            title: "Eyes (HEENT)",
            icon: Icons.visibility_outlined,
            iconColor: Colors.blue,
            controller: eyeController,
          ),
          ExaminationCategoryCard(
            title: "Cardiovascular",
            icon: Icons.favorite_border,
            iconColor: Colors.red,
            controller: heartController,
          ),
          ExaminationCategoryCard(
            title: "Respiratory",
            icon: Icons.air_outlined,
            iconColor: Colors.cyan,
            controller: respController,
          ),
          ExaminationCategoryCard(
            title: "Abdomen",
            icon: Icons.health_and_safety_outlined,
            iconColor: Colors.orange,
            controller: abdomenController,
          ),
        ],
      ),
    );
  }
}