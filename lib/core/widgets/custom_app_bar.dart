import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing; // علشان لو عايز تحط أيقونة الإشعارات أو تسيبها فاضية
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // الألوان المستخرجة من التصميم (Linear Gradient)
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 110, 220, 1), // اللون الفاتح
            Color.fromRGBO(0, 43, 86, 1),   // اللون الغامق
          ],
        ),
        // حواف دائرية من الأسفل بقيمة 20px كما في التصميم
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // زر الرجوع
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBackPressed ?? () => Navigator.pop(context),
              ),

              // العنوان والعنوان الفرعي
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // الجزء الأيمن (مثلاً: أيقونة الإشعارات)
              // لو مفيش trailing هنحط مساحة فاضية عشان نحافظ على توسيط العنوان
              trailing ?? const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  // تحديد ارتفاع الـ App Bar
  @override
  Size get preferredSize => const Size.fromHeight(80.0); // يمكنك تعديل الارتفاع حسب الحاجة
}