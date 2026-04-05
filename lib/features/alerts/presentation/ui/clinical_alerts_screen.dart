import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/features/alerts/data/models/alert_model.dart';
import 'package:cortexia/features/alerts/data/models/override_alert_request.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_cubit.dart';
import 'package:cortexia/features/alerts/presentation/controllers/alerts_state.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicalAlertsScreen extends StatefulWidget {
  final String admissionId;
  const ClinicalAlertsScreen({super.key, required this.admissionId});

  @override
  State<ClinicalAlertsScreen> createState() => _ClinicalAlertsScreenState();
}

class _ClinicalAlertsScreenState extends State<ClinicalAlertsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlertsCubit>().getActiveAlerts(widget.admissionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Clinical Alerts'),
      body: BlocConsumer<AlertsCubit, AlertsState>(
        listener: (context, state) {
          if (state is OverrideAlertSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
          } else if (state is OverrideAlertError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.errorRed),
            );
          }
        },
        builder: (context, state) {
          if (state is AlertsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlertsError) {
            return Center(child: Text(state.message));
          } else if (state is AlertsLoaded || state is OverrideAlertLoading || state is OverrideAlertSuccess || state is OverrideAlertError) {
            final alerts = context.read<AlertsCubit>().activeAlerts;
            if (alerts.isEmpty) {
              return const Center(child: Text('No active alerts'));
            }
            return SingleChildScrollView(
              padding: AppDimens.paddingAll16,
              child: Column(
                children: [
                  _buildTopCountsArea(alerts),
                  SizedBox(height: AppDimens.space16),
                  _buildFiltersArea(alerts.length),
                  SizedBox(height: AppDimens.space16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: alerts.length,
                    separatorBuilder: (_, __) => SizedBox(height: AppDimens.space12),
                    itemBuilder: (context, index) {
                      final alert = alerts[index];
                      return _buildAlertCardFromModel(alert);
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTopCountsArea(List<AlertModel> alerts) {
    int critical = alerts.where((a) => a.severity == 3).length;
    int high = alerts.where((a) => a.severity == 2).length;
    int other = alerts.where((a) => a.severity == 1 || a.severity == 0).length;

    return Row(
      children: [
        Expanded(
          child: _buildCountCard(
            count: critical.toString(),
            label: 'Critical',
            labelColor: AppColors.textSecondary,
            countColor: AppColors.errorRed,
            bgColor: const Color(0x1AF44336), 
            borderColor: const Color(0x4DF44336), 
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: _buildCountCard(
            count: high.toString(),
            label: 'High',
             labelColor: AppColors.textSecondary,
            countColor: AppColors.warningOrange,
            bgColor: const Color(0x1AFF9800),     
            borderColor: const Color(0x4DFF9800), 
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: _buildCountCard(
            count: other.toString(),
            label: 'Other',
             labelColor: AppColors.textSecondary,
            countColor: AppColors.infoBlue, 
            bgColor: const Color(0x1A0066CC),   
            borderColor: const Color(0x4D0066CC), 
          ),
        ),
      ],
    );
  }

  Widget _buildCountCard({
    required String count,
    required String label,
    required Color countColor,
    required Color labelColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimens.space12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: AppDimens.fontXXLarge,
              fontWeight: FontWeight.bold,
              color: countColor,
            ),
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            label,
            style: TextStyle(
              fontSize: AppDimens.fontSmall,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersArea(int total) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimens.space8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space12),
        child: Row(
          children: [
            _buildFilterChip(label: 'All ($total)', isSelected: true),
            SizedBox(width: AppDimens.space8),
            _buildFilterChip(label: 'Critical', isSelected: false),
            SizedBox(width: AppDimens.space8),
            _buildFilterChip(label: 'Vitals', isSelected: false),
            SizedBox(width: AppDimens.space8),
            _buildFilterChip(label: 'Labs', isSelected: false),
            SizedBox(width: AppDimens.space8),
            _buildFilterChip(label: 'Medications', isSelected: false),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({required String label, required bool isSelected}) {
    return Container(
       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.infoBlue : AppColors.scaffoldBg,
        borderRadius: AppDimens.radius8,
        border: Border.all(color: isSelected ? Colors.transparent : AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.white : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: AppDimens.fontMedium,
        ),
      ),
    );
  }

  Widget _buildAlertCardFromModel(AlertModel alert) {
    Color badgeColor = AppColors.infoBlue;
    String badgeText = 'LOW';
    Color iconColor = AppColors.infoBlue;
    IconData iconData = Icons.info_outline;
    Color cardBorderColor = const Color(0x4D0066CC);
    Color cardBgColor = const Color(0x1A0066CC);

    if (alert.severity == 3) {
      badgeColor = AppColors.errorRed;
      badgeText = 'CRITICAL';
      iconColor = AppColors.errorRed;
      iconData = Icons.warning_amber_rounded;
      cardBorderColor = const Color(0x4DF44336);
      cardBgColor = const Color(0x1AF44336);
    } else if (alert.severity == 2) {
      badgeColor = AppColors.warningOrange;
      badgeText = 'HIGH';
      iconColor = AppColors.warningOrange;
      iconData = Icons.priority_high;
      cardBorderColor = const Color(0x4DFF9800);
      cardBgColor = const Color(0x1AFF9800);
    }

    // Rough parsing of time from generatedAt
    String timeText = 'Just now';
    if (alert.generatedAt != null) {
      try {
        final dt = DateTime.parse(alert.generatedAt!);
        final now = DateTime.now();
        final diff = now.difference(dt);
        if (diff.inMinutes < 60) {
          timeText = '${diff.inMinutes} min ago';
        } else if (diff.inHours < 24) {
          timeText = '${diff.inHours} hours ago';
        } else {
          timeText = '${diff.inDays} days ago';
        }
      } catch (_) {}
    }

    return _buildAlertCard(
      alertId: alert.id ?? '',
      title: alert.alertMessage?.split(':').first ?? 'Alert',
      badgeText: badgeText,
      badgeColor: badgeColor,
      description: alert.alertMessage ?? '',
      timeText: timeText,
      typeBadge: 'system', // Default since API doesn't specify type
      primaryAction: 'Override',
      secondaryAction: 'Review',
      iconData: iconData,
      iconColor: iconColor,
      cardBorderColor: cardBorderColor,
      cardBgColor: cardBgColor,
    );
  }

  Widget _buildAlertCard({
    required String alertId,
    required String title,
    required String badgeText,
    required Color badgeColor,
    required String description,
    required String timeText,
    required String typeBadge,
    required String primaryAction,
    required String secondaryAction,
    required IconData iconData,
    required Color iconColor,
    required Color cardBorderColor,
    required Color cardBgColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDimens.paddingAll16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: AppDimens.paddingAll8,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: iconColor, size: 24),
                ),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                         children: [
                           Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: AppDimens.fontMedium,
                                  fontWeight: FontWeight.bold,
                                  color: iconColor, 
                                ),
                              ),
                           ),
                           Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: badgeColor,
                                borderRadius: AppDimens.radius8,
                              ),
                              child: Text(
                                badgeText,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                           ),
                         ],
                      ),
                      SizedBox(height: AppDimens.space4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: AppDimens.fontSmall,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppDimens.space8),
                      Row(
                        children: [
                          Text(
                            timeText,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: AppDimens.space8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: AppDimens.radius8,
                            ),
                            child: Text(
                              typeBadge,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: cardBorderColor),
          Padding(
            padding: AppDimens.paddingAll12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: AppDimens.radius8,
                  child: Container(
                     padding: EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: 8),
                     decoration: BoxDecoration(
                        color: AppColors.scaffoldBg,
                        borderRadius: AppDimens.radius8,
                        border: Border.all(color: AppColors.border),
                     ),
                     child: Text(
                        secondaryAction,
                        style: TextStyle(
                           color: AppColors.textSecondary,
                           fontWeight: FontWeight.w600,
                           fontSize: AppDimens.fontMedium,
                        ),
                     ),
                  ),
                ),
                SizedBox(width: AppDimens.space8),
                InkWell(
                  onTap: () => _showOverrideDialog(alertId),
                  borderRadius: AppDimens.radius8,
                  child: Container(
                     padding: EdgeInsets.symmetric(horizontal: AppDimens.space16, vertical: 8),
                     decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: AppDimens.radius8,
                     ),
                     child: Text(
                        primaryAction,
                        style: TextStyle(
                           color: AppColors.white,
                           fontWeight: FontWeight.w600,
                           fontSize: AppDimens.fontMedium,
                        ),
                     ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOverrideDialog(String alertId) {
    final reasonController = TextEditingController();
    final procedureController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Override Alert'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(labelText: 'Reason for override'),
            ),
            TextField(
              controller: procedureController,
              decoration: const InputDecoration(labelText: 'Related Procedure ID (Optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final user = await AppCache.getUserData();
              if (!context.mounted) return;
              
              final doctorId = user?.userIdInSystem ?? 'DOC-123';
              final cubit = context.read<AlertsCubit>();
              
              cubit.overrideAlert(
                OverrideAlertRequest(
                  alertId: alertId,
                  doctorId: doctorId,
                  reason: reasonController.text.isEmpty ? 'Clinical Judgement' : reasonController.text,
                  procedureId: procedureController.text,
                ),
                widget.admissionId,
              );
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
