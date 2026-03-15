import 'package:flutter/material.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart'; // تأكد من استيراد المسار الصحيح

class SummaryActionCard extends StatelessWidget {
  final String count;
  final String label;
  final String buttonText;
  final Color themeColor;       // اللون المستخدم للرقم وللخلفية
  final Color backgroundColor;
  final VoidCallback onAddTap;

  const SummaryActionCard({
    Key? key,
    required this.count,
    required this.label,
    required this.buttonText,
    this.themeColor = const Color(0xFF00ACC1),
    this.backgroundColor = const Color(0xFFF0F9FB),
    required this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: themeColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // الرقم والنص
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          // الزرار باستخدام CustomElevatedButton
          SizedBox(
            width: 120, // عرض مناسب للزرار
            child: CustomElevatedButton(
              text: buttonText,
              onPressed: onAddTap,
              height: 40, // ارتفاع أقل من الافتراضي ليتناسب مع الكارت
              borderRadius: 12,
              backgroundColor: themeColor, // استخدام نفس لون الثيم
            ),
          ),
        ],
      ),
    );
  }
}