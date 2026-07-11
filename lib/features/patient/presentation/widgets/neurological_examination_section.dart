import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'examination_section_card.dart';

class NeurologicalExaminationSection extends StatelessWidget {
  final TextEditingController? eyeController;
  final TextEditingController? skinController;
  final TextEditingController? lipsController;

  const NeurologicalExaminationSection({
    super.key,
    this.eyeController,
    this.skinController,
    this.lipsController,
  });

  @override
  Widget build(BuildContext context) {
    return ExaminationSectionCard(
      title: "Neurological & General",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: eyeController,
            labelText: "Eye / Pupil Response",
            hintText: "Describe pupil response...",
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: skinController,
            labelText: "Skin Status",
            hintText: "Describe skin status...",
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: lipsController,
            labelText: "Lips Status",
            hintText: "Describe lips status...",
          ),
        ],
      ),
    );
  }
}