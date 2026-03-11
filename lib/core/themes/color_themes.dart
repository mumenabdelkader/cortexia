import 'package:flutter/material.dart';

class AppColors {
  // --- 1. ألوان الهوية (Branding & Global) ---
  static const Color primaryBlue = Color(0xFF006EDC);  // الأزرق الزاهي
  static const Color darkBlue = Color(0xFF002B56);     // الأزرق الداكن جداً (العناوين والأزرار)
  static const Color scaffoldBg = Color(0xFFF5F7F9);   // رمادي فاتح جداً لخلفية التطبيق
  static const Color white = Colors.white;

  // --- 2. ألوان الحالات الطبية (Status & Badges) ---
  // مهمة جداً للكروت اللي فيها "Stable", "Critical", إلخ
  static const Color successGreen = Color(0xFF4CAF50);  // أخضر (Stable)
  static const Color errorRed = Color(0xFFE53935);      // أحمر (Critical/Alerts)
  static const Color warningOrange = Color(0xFFFFB300); // برتقالي (Pending/Warning)
  static const Color infoBlue = Color(0xFF2196F3);      // أزرق (Information)

  // --- 3. ألوان خلفيات العناصر (Surface/Container Colors) ---
  // دي الألوان اللي بتبقى "خلفية" ورا الكلام الملون
  static const Color successBg = Color(0xFFE8F5E9);     // أخضر باهت جداً ورا كلمة Stable
  static const Color errorBg = Color(0xFFFFEBEE);       // أحمر باهت جداً ورا Alerts
  static const Color infoBg = Color(0xFFE3F2FD);        // أزرق باهت ورا Lab Results ready
  static const Color warningBg = Color(0xFFFFF8E1);     // أصفر باهت ورا الملاحظات

  // --- 4. ألوان النصوص (Typography) ---
  static const Color textMain = Color(0xFF1A1A1A);      // أسود للعناوين
  static const Color textSecondary = Color(0xFF757575); // رمادي للبيانات الفرعية
  static const Color textLight = Color(0xFF9E9E9E);     // رمادي فاتح جداً (للتاريخ والوحدات)

  // --- 5. الحدود والظلال (Borders & Shadows) ---
  static const Color border = Color(0xFFE0E0E0);        // حدود الكروت
  static const Color divider = Color(0xFFEEEEEE);       // الخط الفاصل بين العناصر

  // --- 6. التدرجات (Gradients) ---
  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryBlue, darkBlue],
  );
}