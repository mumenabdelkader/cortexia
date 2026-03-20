import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:cortexia/features/authentication/presentation/controllers/reset_password_cubit.dart';
import 'package:cortexia/features/authentication/presentation/controllers/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ResetPasswordCubit(locator<AuthRepoInterface>());
        cubit.email = widget.email;
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        extendBodyBehindAppBar: true,
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
                child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.response.message ?? "Password reset successfully."),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.loginScreen, (route) => false);
                    } else if (state is ResetPasswordError) {
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
                        final cubit = context.read<ResetPasswordCubit>();
                        return Form(
                          key: cubit.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/small_logo.png',
                                height: 80,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.lock_reset,
                                  size: 80,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Reset Password",
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: AppColors.textMain,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Enter the OTP sent to your email and your new password.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textLight,
                                ),
                              ),
                              const SizedBox(height: 32),
                              CustomTextFormField(
                                labelText: "OTP",
                                hintText: "Enter 6-digit OTP",
                                prefixIcon: Icons.pin_outlined,
                                controller: cubit.otpController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the OTP';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextFormField(
                                labelText: "New Password",
                                hintText: "Enter new password",
                                prefixIcon: Icons.lock_outline,
                                isPassword: isPasswordObscured,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordObscured = !isPasswordObscured;
                                    });
                                  },
                                ),
                                controller: cubit.newPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your new password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                                builder: (context, state) {
                                  if (state is ResetPasswordLoading) {
                                    return const CircularProgressIndicator(
                                      color: AppColors.primaryBlue,
                                    );
                                  }
                                  return CustomElevatedButton(
                                    text: "Reset Password",
                                    onPressed: () {
                                      if (cubit.formKey.currentState!.validate()) {
                                        cubit.emitResetPasswordStates();
                                      }
                                    },
                                  );
                                },
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
