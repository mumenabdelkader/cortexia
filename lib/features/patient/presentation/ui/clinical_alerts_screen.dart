import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';

class ClinicalAlertsScreen extends StatelessWidget {
  const ClinicalAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Clinical Alarts'),
      body: SingleChildScrollView(
        padding: AppDimens.paddingAll16,
        child: Column(
          children: [
            _buildTopCountsArea(),
            SizedBox(height: AppDimens.space16),
            _buildFiltersArea(),
            SizedBox(height: AppDimens.space16),
            _buildAlertCard(
              title: 'Sepsis Alert',
              badgeText: 'CRITICAL',
              badgeColor: AppColors.errorRed,
              description: 'SIRS criteria met: Temp 38.5°C, HR 105, WBC 15.2',
              timeText: '5 min ago',
              typeBadge: 'clinical',
              primaryAction: 'Review',
              secondaryAction: 'Acknowledge',
              iconData: Icons.warning_amber_rounded,
              iconColor: AppColors.errorRed,
              cardBorderColor: const Color(0x4DF44336), // 30% opacity
              cardBgColor: const Color(0x1AF44336), // 10% opacity
            ),
            SizedBox(height: AppDimens.space12),
            _buildAlertCard(
              title: 'Low Oxygen Saturation',
              badgeText: 'HIGH',
              badgeColor: AppColors.warningOrange,
              description: 'SpO₂ dropped to 91% - Patient may need oxygen adjustment',
              timeText: '15 min ago',
              typeBadge: 'vitals',
              primaryAction: 'Check Patient',
              secondaryAction: 'Dismiss',
              iconData: Icons.air,
              iconColor: AppColors.warningOrange,
              cardBorderColor: const Color(0x4DFF9800),
              cardBgColor: const Color(0x1AFF9800),
            ),
            SizedBox(height: AppDimens.space12),
            _buildAlertCard(
              title: 'Drug Interaction Warning',
              badgeText: 'HIGH',
              badgeColor: AppColors.warningOrange,
              description: 'Warfarin + Aspirin: Increased bleeding risk',
              timeText: '30 min ago',
              typeBadge: 'medication',
              primaryAction: 'Review Meds',
              secondaryAction: 'Consult',
              iconData: Icons.medication,
              iconColor: AppColors.warningOrange,
              cardBorderColor: const Color(0x4DFF9800),
              cardBgColor: const Color(0x1AFF9800),
            ),
             SizedBox(height: AppDimens.space12),
            _buildAlertCard(
              title: 'Abnormal Lab Result',
              badgeText: 'MEDIUM',
              badgeColor: AppColors.infoBlue, 
              description: 'Potassium 3.2 mEq/L (Low) - Consider supplementation',
              timeText: '1 hour ago',
              typeBadge: 'lab',
              primaryAction: 'Order K+',
              secondaryAction: 'Monitor',
              iconData: Icons.science,
              iconColor: AppColors.infoBlue,
              cardBorderColor: const Color(0x4D0066CC), // derived from the blue hex
              cardBgColor: const Color(0x1A0066CC),
            ),
            SizedBox(height: AppDimens.space12),
            _buildAlertCard(
              title: 'Elevated Temperature',
              badgeText: 'MEDIUM',
              badgeColor: AppColors.infoBlue,
              description: 'Temperature trending up: 38.2°C → 38.5°C',
              timeText: '2 hours ago',
              typeBadge: 'vitals',
              primaryAction: 'Give Antipyretic',
              secondaryAction: 'Culture',
              iconData: Icons.thermostat,
              iconColor: AppColors.infoBlue,
              cardBorderColor: const Color(0x4D0066CC),
              cardBgColor: const Color(0x1A0066CC),
            ),
             SizedBox(height: AppDimens.space12),
            _buildAlertCard(
              title: 'Medication Due',
              badgeText: 'LOW',
              badgeColor: AppColors.infoBlue, 
              description: 'Amoxicillin 500mg PO due in 15 minutes',
              timeText: 'Now',
              typeBadge: 'medication',
              primaryAction: 'Administer',
              secondaryAction: 'Delay',
              iconData: Icons.access_time,
              iconColor: AppColors.infoBlue,
              cardBorderColor: const Color(0x4D0066CC),
              cardBgColor: const Color(0x1A0066CC),
            ),
             SizedBox(height: AppDimens.space12),
            _buildAlertCard(
              title: 'IV Bag Low',
              badgeText: 'LOW',
              badgeColor: AppColors.infoBlue,
              description: 'Normal Saline remaining: <200mL',
              timeText: '10 min ago',
              typeBadge: 'clinical',
              primaryAction: 'Replace',
              secondaryAction: 'Dismiss',
              iconData: Icons.water_drop,
              iconColor: AppColors.infoBlue,
              cardBorderColor: const Color(0x4D0066CC),
              cardBgColor: const Color(0x1A0066CC),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCountsArea() {
    return Row(
      children: [
        Expanded(
          child: _buildCountCard(
            count: '1',
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
            count: '2',
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
            count: '4',
            label: 'Other',
             labelColor: AppColors.textSecondary,
            countColor: AppColors.infoBlue, // Figma uses the primary blue color
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

  Widget _buildFiltersArea() {
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
            _buildFilterChip(label: 'All (7)', isSelected: true),
            SizedBox(width: AppDimens.space8),
            _buildFilterChip(label: 'Critical (1)', isSelected: false),
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
       padding: EdgeInsets.symmetric(horizontal: AppDimens.space12, vertical: 6),
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

  Widget _buildAlertCard({
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
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: badgeColor,
                                borderRadius: AppDimens.radius8,
                              ),
                              child: Text(
                                badgeText,
                                style: TextStyle(
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
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(width: AppDimens.space8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: AppDimens.radius8,
                            ),
                            child: Text(
                              typeBadge,
                              style: TextStyle(
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
                  onTap: () {},
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
}
