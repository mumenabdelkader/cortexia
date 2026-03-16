import 'package:flutter/material.dart';

class DashboardActionCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const DashboardActionCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)), // حدود خفيفة جداً
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // الأيقونة في الأعلى
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),

            const SizedBox(height: 16),

            // العنوان الأساسي
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 4),

            // النص الفرعي الصغير (View timeline / check reports / etc)
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8), // رمادي باهت
              ),
            ),
          ],
        ),
      ),
    );
  }
}
