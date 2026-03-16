import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:cortexia/features/authentication/presentation/controllers/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // توفير الـ Cubit للشاشة باستخدام GetIt
    return BlocProvider(
      create: (context) => LoginCubit(locator<AuthRepoInterface>()),
      child: Scaffold(
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
                child: BlocListener<LoginCubit, LoginState>(
                  // التعامل مع حالات النجاح والفشل (Navigation & Popups)
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushNamed(context, Routes.mainNavigationScreen);
                    } else if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.errorRed,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Builder(
                        builder: (context) {
                          final cubit = context.read<LoginCubit>();
                          return Form(
                            key: cubit.formKey, // الفورم كي للتحقق من الحقول
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // الشعار (Logo)
                                Image.asset(
                                  'assets/images/small_logo.png',
                                  height: 80,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.medical_services_outlined,
                                    size: 80,
                                    color: AppColors.primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  "Log in",
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    color: AppColors.textMain,
                                    fontSize: 28,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // حقل الـ Email / Staff ID
                                CustomTextFormField(
                                  labelText: "Staff ID / Email",
                                  hintText: "DR-2024-001",
                                  prefixIcon: Icons.person_outline,
                                  controller: cubit.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your ID or Email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),

                                // حقل الـ Password
                                CustomTextFormField(
                                  labelText: "Password",
                                  hintText: "••••••••",
                                  prefixIcon: Icons.lock_outline,
                                  isPassword: true,
                                  controller: cubit.passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),

                                // زرار تسجيل الدخول مع حالة التحميل
                                BlocBuilder<LoginCubit, LoginState>(
                                  builder: (context, state) {
                                    if (state is LoginLoading) {
                                      return const CircularProgressIndicator(
                                        color: AppColors.primaryBlue,
                                      );
                                    }
                                    return CustomElevatedButton(
                                      text: "Sign In",
                                      onPressed: () {
                                        // التحقق محلياً قبل إرسال الطلب للسيرفر
                                        if (cubit.formKey.currentState!.validate()) {
                                          cubit.emitLoginStates();
                                        }
                                      },
                                    );
                                  },
                                ),

                                const SizedBox(height: 16),

                                // حقوق الملكية
                                Text(
                                  "© 2026 MediCare Pro. HIPAA Compliant",
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}