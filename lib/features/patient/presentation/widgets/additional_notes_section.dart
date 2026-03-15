import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'examination_section_card.dart';

class AdditionalNotesSection extends StatelessWidget {
  final TextEditingController? controller;

  const AdditionalNotesSection({
    Key? key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ExaminationSectionCard(
      title: "Additional Notes",
      icon: Icons.note_alt_outlined,
      iconColor: const Color(0xFF64748B),
      child: CustomTextFormField(
        controller: controller,
        hintText: "Add any additional observations or concerns...",
        fillColor: Colors.white, // جعل الخلفية بيضاء لتمييزها داخل الكارت الرمادي
        // يمكنك إضافة برامتر maxLines للكلاس الخاص بك إذا أردت زيادة الارتفاع
        // أو الاعتماد على التصميم الافتراضي للكلاس
      ),
    );
  }
}