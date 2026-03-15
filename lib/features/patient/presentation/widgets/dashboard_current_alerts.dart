import 'package:flutter/material.dart';

class DashboardCurrentAlerts extends StatelessWidget {
  const DashboardCurrentAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الكارت العلوي
          Row(
            children: const [
              Icon(Icons.error_outline, color: Colors.orange, size: 22),
              SizedBox(width: 8),
              Text(
                "Current Alerts",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // التنبيه الأول: نتائج المعمل
          _buildAlertItem(
            title: "Lab results ready",
            subtitle: "10 min ago",
            icon: Icons.info_outline,
            iconColor: Colors.cyan,
            bgColor: const Color(0xFFE0F7FA), // سماوي فاتح جداً
            borderColor: Colors.cyan.shade100,
          ),

          const SizedBox(height: 12),

          // التنبيه الثاني: الأدوية
          _buildAlertItem(
            title: "Medication due in 30 min",
            subtitle: "Now",
            icon: Icons.error_outline,
            iconColor: Colors.orange,
            bgColor: const Color(0xFFFFF8E1), // برتقالي فاتح جداً
            borderColor: Colors.orange.shade100,
            hasCriticalDot: true, // النقطة الحمراء اللي فوق الأيقونة
          ),
        ],
      ),
    );
  }

  // Widget فرعي لبناء كل تنبيه لوحده
  Widget _buildAlertItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    bool hasCriticalDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Icon(icon, color: iconColor, size: 24),
              if (hasCriticalDot)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}