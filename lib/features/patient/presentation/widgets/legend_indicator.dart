import 'dart:ui';

import 'package:flutter/cupertino.dart';

class LegendIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const LegendIndicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // عشان ياخد مساحة الكلمة بس
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // ممكن تخليها BoxShape.rectangle لو عايزها مربع
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}