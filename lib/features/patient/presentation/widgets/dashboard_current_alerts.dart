import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_cubit.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_state.dart';
import 'package:cortexia/features/alerts/data/models/alert_severity.dart';

class DashboardCurrentAlerts extends StatelessWidget {
  final String? admissionId;
  const DashboardCurrentAlerts({super.key, this.admissionId});

  @override
  Widget build(BuildContext context) {
    if (admissionId == null || admissionId!.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (context) =>
          GetIt.I.get<AlertsCubit>()..getActiveAlerts(admissionId!),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            BlocBuilder<AlertsCubit, AlertsState>(
              builder: (context, state) {
                if (state is AlertsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AlertsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is AlertsLoaded) {
                  final alerts = state.activeAlerts;
                  if (alerts.isEmpty) {
                    return const Text(
                      "No active alerts at the moment.",
                      style: TextStyle(color: Colors.grey),
                    );
                  }

                  return Column(
                    children: alerts.take(3).map((alert) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildAlertItem(
                          title: alert.alertMessage ?? "Unknown Alert",
                          subtitle: _formatTimeAgo(alert.generatedAt),
                          icon: _getIcon(alert.severity),
                          iconColor: _getIconColor(alert.severity),
                          bgColor: _getBgColor(alert.severity),
                          borderColor: _getBorderColor(alert.severity),
                          hasCriticalDot: alert.severity == AlertSeverity.critical || alert.severity == AlertSeverity.high,
                        ),
                      );
                    }).toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(String? dateStr) {
    if (dateStr == null) return "Unknown";
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
      if (diff.inHours < 24) return "${diff.inHours} hours ago";
      return "${diff.inDays} days ago";
    } catch (_) {
      return "Recently";
    }
  }

  Color _getIconColor(AlertSeverity? severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red;
      case AlertSeverity.high:
        return Colors.deepOrange;
      case AlertSeverity.medium:
        return Colors.orange;
      case AlertSeverity.low:
        return Colors.yellow.shade700;
      case AlertSeverity.info:
        return Colors.cyan;
      default:
        return Colors.blue;
    }
  }

  Color _getBgColor(AlertSeverity? severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return const Color(0xFFFFEBEE); 
      case AlertSeverity.high:
        return const Color(0xFFFBE9E7); 
      case AlertSeverity.medium:
        return const Color(0xFFFFF8E1); 
      case AlertSeverity.low:
        return const Color(0xFFFFFDE7); 
      case AlertSeverity.info:
        return const Color(0xFFE0F7FA); 
      default:
        return Colors.blue.shade50;
    }
  }

  Color _getBorderColor(AlertSeverity? severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return Colors.red.shade100;
      case AlertSeverity.high:
        return Colors.deepOrange.shade100;
      case AlertSeverity.medium:
        return Colors.orange.shade100;
      case AlertSeverity.low:
        return Colors.yellow.shade200;
      case AlertSeverity.info:
        return Colors.cyan.shade100;
      default:
        return Colors.blue.shade100;
    }
  }

  IconData _getIcon(AlertSeverity? severity) {
    switch (severity) {
      case AlertSeverity.critical:
      case AlertSeverity.high:
        return Icons.warning_amber_rounded;
      case AlertSeverity.medium:
      case AlertSeverity.low:
        return Icons.error_outline;
      case AlertSeverity.info:
        return Icons.info_outline;
      default:
        return Icons.notifications_none;
    }
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
          Expanded(
            child: Column(
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
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
