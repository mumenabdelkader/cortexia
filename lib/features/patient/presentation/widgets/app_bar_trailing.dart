import 'package:cortexia/features/patient/presentation/ui/new_patient_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class AppBarTrailing extends StatelessWidget {
  const AppBarTrailing({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewPatientRegistrationScreen(),));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              // هنا التعديل: نستخدم نفس التدرج بتاع الـ AppBar عشان يظهر بنفس اللون بالظبط
              gradient: AppColors.appBarGradient,
              borderRadius: BorderRadius.circular(12),
              // إضافة Shadow خفيف عشان الزرار يظهر "بارز" شوية عن الخلفية
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha:0.2), // حد فاتح بسيط للتحديد
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  "New Patient",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}