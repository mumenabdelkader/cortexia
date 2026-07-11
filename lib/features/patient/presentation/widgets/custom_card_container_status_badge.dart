import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String statusText; // النص (Active, Completed, etc.)
  final bool isActive;      // المتغير الـ bool اللي بيحدد الحالة

  const StatusBadge({
    super.key,
    required this.statusText,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    // تحديد الألوان بناءً على قيمة الـ bool
    final Color themeColor = isActive ? const Color(0xFF22C55E) : const Color(0xFF64748B);
    final Color bgColor = isActive ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor, // لون الخلفية الفاتح
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withValues(alpha:0.3)),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: themeColor, // لون النص الأساسي
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}