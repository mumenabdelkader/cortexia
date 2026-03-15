import 'package:flutter/material.dart';

class ExaminationCategoryCard extends StatelessWidget {
  final String title;        // عنوان الفئة (مثل Respiratory)
  final IconData icon;       // الأيقونة الخاصة بالفئة
  final Color iconColor;     // لون الأيقونة
  final String? content;     // النص الذي يظهر داخل الحقل الأبيض (اختياري)
  final String hintText;     // النص التوجيهي في حال عدم وجود محتوى

  const ExaminationCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.content,
    this.hintText = "Enter findings...",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12), // مسافة بين الكروت
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // خلفية زرقاء رمادية فاتحة جداً
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي: الأيقونة والعنوان
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // الحقل الأبيض الداخلي (Container يشبه حقل الإدخال)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              (content == null || content!.isEmpty) ? hintText : content!,
              style: TextStyle(
                fontSize: 14,
                color: (content == null || content!.isEmpty)
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}