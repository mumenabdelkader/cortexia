import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';


import '../../../patient/presentation/ui/patient_list_screen.dart';
class LoginScreen extends StatelessWidget {
   const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدام الخلفية الزرقاء المتدرجة كما في التصميم
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.appBarGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                // الكارت الأبيض اللي شايل الفورم
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // الشعار (Logo)
                    Image.asset(
                      'assets/images/small_logo.png', // تأكد من إضافة مسار اللوجو
                      height: 80,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.medical_services_outlined,
                        size: 80,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // كلمة Log in
                    Text(
                      "Log in",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColors.textMain,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // حقل Staff ID
                    const CustomTextFormField(
                      labelText: "Staff ID",
                      hintText: "DR-2024-001",
                      prefixIcon: Icons.person_outline,

                    ),
                    const SizedBox(height: 20),

                    // حقل Password
                    const CustomTextFormField(
                      labelText: "Password",
                      hintText: "••••••••",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 30),

                    // زرار Sign In
                    CustomElevatedButton(
                      text: "Sign In",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientListScreen(),));
                      },
                    ),

                    const SizedBox(height: 16),

                    // حقوق الحقوق في الأسفل
                    Text(
                      "© 2026 MediCare Pro. HIPAA Compliant",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}