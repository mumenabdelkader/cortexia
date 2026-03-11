import 'package:flutter/material.dart';
import 'color_themes.dart'; // تأكد من وجود كلاس الألوان في مشروعك

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryBlue,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      fontFamily: 'Roboto',

      // ربط الألوان بنظام ColorScheme الأساسي لسهولة الاستخدام
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        secondary: AppColors.darkBlue,
        surface: AppColors.white,
        error: AppColors.errorRed,
      ),

      textTheme: const TextTheme(
        // --- 1. خطوط شاشات الترحيب (Welcome Screens) ---

        // للعناوين الرئيسية الضخمة (Smart ICU Patient Monitoring)
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
          height: 1.2, // لمطابقة تباعد الأسطر في التصميم
        ),

        // لنصوص الوصف تحت العناوين في شاشات الترحيب
        headlineMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          height: 1.5,
        ),

        // --- 2. خطوط الـ AppBar والواجهات الرئيسية ---

        // العنوان الأبيض في الـ AppBar (Patient Dashboard)
        displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),

        // --- 3. خطوط البيانات والكروت (Dashboard & Cards) ---

        // أسماء المرضى في الكروت الكبيرة (John Anderson)
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textMain,
          letterSpacing: 0.5,
        ),

        // عناوين الأقسام الفرعية (Vital Signs / Current Alerts)
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textMain,
        ),

        // القيم الطبية والأرقام الواضحة في الـ Vitals
        headlineSmall: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textMain,
        ),

        // النصوص الأساسية (Pneumonia / ICU-101)
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textMain,
        ),

        // النصوص الرمادية الوصفية (ID / Gender / Admitted)
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
        ),

        // الوحدات الصغيره (days / bpm)
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),

        // التوقيت الصغير (10 min ago)
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
          color: AppColors.textLight,
        ),
      ),
    );
  }
}