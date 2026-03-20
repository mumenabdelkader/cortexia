import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: CustomAppBar(
        title: "Medical History",
      ),
      body: Center(
        child: Text(
          "Medical History Screen",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textMain,
          ),
        ),
      ),
    );
  }
}
