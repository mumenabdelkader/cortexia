import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFFFE9235);
  static const Color primaryLight = Color(0xFFFFB366);
  static const Color primaryDark = Color(0xFFE67E22);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF112121);
  static const Color textSecondary = Color(0xFF6C7278);
  static const Color textHint = Color(0xFF838383);
  static const Color textDisabled = Color(0xFF999999);

  // Border Colors
  static const Color border = Color(0xFFDFDFDF);
  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color borderFocus = Color(0xFFEAECF0);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Shadow Colors
  static const Color shadow = Color(0x3DE4E5E7);
  static final Color shadowLight = Colors.black.withValues(alpha: 0.05);
  static final Color shadowMedium = Colors.black.withValues(alpha: 0.1);
}
