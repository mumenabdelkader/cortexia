import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color themeColor;
  final Color bgColor;
  final bool isSmall; // البرامتر الجديد للتحكم في الحجم واللون

  const CustomInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.themeColor,
    required this.bgColor,
    this.isSmall = false, // القيمة الافتراضية هي الحجم الكبير
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // تقليل الـ padding لو الحجم صغير
        padding: EdgeInsets.symmetric(
            vertical: isSmall ? 8 : 12,
            horizontal: isSmall ? 4 : 8
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // تصغير الأيقونة لو isSmall بـ true
            Icon(
                icon,
                color: themeColor,
                size: isSmall ? 16 : 22
            ),
            SizedBox(height: isSmall ? 4 : 8),
            // تصغير حجم الخط للقيمة
            Text(
              value,
              style: TextStyle(
                color: themeColor,
                fontSize: isSmall ? 13 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            // تصغير حجم العنوان وتغيير لونه لو محتاج
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSmall ? themeColor.withValues(alpha:0.8) : const Color(0xFF757575),
                fontSize: isSmall ? 9 : 11,
                fontWeight: isSmall ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}