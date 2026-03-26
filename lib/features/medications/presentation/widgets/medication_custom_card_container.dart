import 'package:cortexia/features/patient/presentation/widgets/custom_card_container_status_badge.dart';
import 'package:flutter/material.dart';

class CustomCardContainer extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget child;
  final List<Widget>? actionButtons;

  // البرامترات الجديدة للـ Badge
  final String? statusText;
  final bool? isActive; // الـ bool المطلوب

  const CustomCardContainer({
    super.key,
    required this.title,
    this.subTitle,
    required this.child,
    this.actionButtons,
    this.statusText,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)), // حدود الكارت الخارجي
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي: العنوان + الـ Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    if (subTitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subTitle!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                    ],
                  ],
                ),
              ),
              // استدعاء كلاس الـ Badge إذا كانت البيانات موجودة
              if (statusText != null && isActive != null)
                StatusBadge(statusText: statusText!, isActive: isActive!),
            ],
          ),

          const SizedBox(height: 16),

          // المحتوى الداخلي (الخلفية الغامقة قليلاً)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),

          // منطقة الأزرار
          if (actionButtons != null && actionButtons!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Row(
              children: actionButtons!.map((btn) => Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: btn,
              ))).toList(),
            ),
          ],
        ],
      ),
    );
  }
}