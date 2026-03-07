import 'package:cortexia/core/thems/color_thems.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final double borderRadius;

  // البرامترات الجديدة الاختيارية
  final Color? backgroundColor; // لون خلفية ثابت (اختياري)
  final Color? textColor;       // لون النص (اختياري)
  final Gradient? gradient;      // إمكانية تمرير تدرج مختلف

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 50.0,
    this.borderRadius = 10.0,
    this.backgroundColor,
    this.textColor,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        // المنطق: لو مبعتش لون خلفية، استخدم التدرج الافتراضي
        // لو بعت لون خلفية، التدرج بيبقى null علشان اللون يظهر
        gradient: backgroundColor == null ? (gradient ?? AppColors.appBarGradient) : null,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: (backgroundColor ?? AppColors.primaryBlue).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: textColor ?? Colors.white, // أبيض افتراضياً
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}