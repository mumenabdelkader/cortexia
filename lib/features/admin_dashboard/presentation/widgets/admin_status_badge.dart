import 'package:cortexia/core/themes/color_themes.dart';
import 'package:flutter/material.dart';

/// Colored badge chip for displaying status labels (room/bed/user/role).
class AdminStatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color? backgroundColor;
  final IconData? icon;

  const AdminStatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.backgroundColor,
    this.icon,
  });

  /// Factory constructors for common states
  factory AdminStatusBadge.available() => const AdminStatusBadge(
        label: 'Available',
        color: AppColors.successGreen,
        backgroundColor: AppColors.successBg,
        icon: Icons.check_circle_outline,
      );

  factory AdminStatusBadge.unavailable() => const AdminStatusBadge(
        label: 'Unavailable',
        color: AppColors.errorRed,
        backgroundColor: AppColors.errorBg,
        icon: Icons.cancel_outlined,
      );

  factory AdminStatusBadge.occupied() => const AdminStatusBadge(
        label: 'Occupied',
        color: AppColors.warningOrange,
        backgroundColor: AppColors.warningBg,
        icon: Icons.bed,
      );

  factory AdminStatusBadge.maintenance() => const AdminStatusBadge(
        label: 'Maintenance',
        color: AppColors.textSecondary,
        backgroundColor: AppColors.divider,
        icon: Icons.build_outlined,
      );

  factory AdminStatusBadge.active() => const AdminStatusBadge(
        label: 'Active',
        color: AppColors.successGreen,
        backgroundColor: AppColors.successBg,
        icon: Icons.person_outline,
      );

  factory AdminStatusBadge.inactive() => const AdminStatusBadge(
        label: 'Inactive',
        color: AppColors.errorRed,
        backgroundColor: AppColors.errorBg,
        icon: Icons.person_off_outlined,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 13),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
