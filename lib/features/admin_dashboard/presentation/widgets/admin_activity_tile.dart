import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/dashboard_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Recent activity tile for the dashboard overview section.
class AdminActivityTile extends StatelessWidget {
  final SystemActivityModel activity;

  const AdminActivityTile({super.key, required this.activity});

  Color get _actionColor {
    switch (activity.action) {
      case 'Create':
        return AppColors.successGreen;
      case 'Update':
        return AppColors.warningOrange;
      case 'Delete':
        return AppColors.errorRed;
      default:
        return AppColors.infoBlue;
    }
  }

  IconData get _actionIcon {
    switch (activity.action) {
      case 'Create':
        return Icons.add_circle_outline;
      case 'Update':
        return Icons.edit_outlined;
      case 'Delete':
        return Icons.delete_outline;
      default:
        return Icons.info_outline;
    }
  }

  String get _formattedTime {
    try {
      final dt = DateTime.parse(activity.timestamp);
      return DateFormat('MMM d, HH:mm').format(dt);
    } catch (_) {
      return activity.timestamp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        children: [
          // Action icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _actionColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_actionIcon, color: _actionColor, size: 18),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: activity.action,
                        style: TextStyle(
                          color: _actionColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const TextSpan(
                        text: ' — ',
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 13),
                      ),
                      TextSpan(
                        text: activity.entityName,
                        style: const TextStyle(
                          color: AppColors.textMain,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  activity.userId != null
                      ? 'User: ${activity.userId!.substring(0, 8)}...'
                      : 'System',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          // Timestamp
          Text(
            _formattedTime,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
