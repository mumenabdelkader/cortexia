import 'package:flutter/material.dart';

class VitalStatusCard extends StatelessWidget {
  final String label;        // مثل Temperature
  final String value;        // مثل 37.2
  final String unit;         // مثل °C
  final String statusText;   // مثل Normal
  final Color statusColor;   // مثل Colors.green

  const VitalStatusCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    this.statusText = "Normal",
    this.statusColor = const Color(0xFF4CAF50), // اللون الأخضر من التصميم
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // يمكنك جعل العرض مرناً حسب الحاجة
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF), // لون الخلفية الأزرق الباهت جداً
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي: العنوان + كبسولة الحالة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withValues(alpha:0.5)),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // القيمة الرقمية داخل خلفية بيضاء
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // الوحدة القياسية في الأسفل
          Text(
            unit,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}