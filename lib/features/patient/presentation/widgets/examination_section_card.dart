import 'package:flutter/material.dart';

class ExaminationSectionCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? iconColor;
  final Widget child; // هذا هو الجزء المتغير الذي سنضعه داخل الحاوية

  const ExaminationSectionCard({
    super.key,
    required this.title,
    this.icon,
    this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1), // إطار خفيف
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان والأيقونة
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor ?? Colors.blue, size: 22),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // المحتوى المتغير (Child)
          child,
        ],
      ),
    );
  }
}