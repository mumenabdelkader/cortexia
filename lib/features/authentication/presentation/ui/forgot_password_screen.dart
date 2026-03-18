import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:cortexia/features/authentication/presentation/controllers/forgot_password_cubit.dart';
import 'package:cortexia/features/authentication/presentation/controllers/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/themes/color_themes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(locator<AuthRepoInterface>()),
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
                child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("If an account with that email exists, a password reset OTP has been sent."),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.of(context).pop(); // Return to login
                    } else if (state is ForgotPasswordError) {
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
                          final cubit = context.read<ForgotPasswordCubit>();
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
                                  "Forgot Password",
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    color: AppColors.textMain,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Enter your email address to receive a password reset code.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textLight,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                CustomTextFormField(
                                  labelText: "Email",
                                  hintText: "example@example.com",
                                  prefixIcon: Icons.email_outlined,
                                  controller: cubit.emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                                  builder: (context, state) {
                                    if (state is ForgotPasswordLoading) {
                                      return const CircularProgressIndicator(
                                        color: AppColors.primaryBlue,
                                      );
                                    }
                                    return CustomElevatedButton(
                                      text: "Send Reset Link",
                                      onPressed: () {
                                        if (cubit.formKey.currentState!.validate()) {
                                          cubit.emitForgotPasswordStates();
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
