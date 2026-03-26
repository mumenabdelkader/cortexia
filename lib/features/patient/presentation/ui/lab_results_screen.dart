import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Laboratory Results'),
      body: SingleChildScrollView(
        padding: AppDimens.paddingAll16,
        child: Column(
          children: [
            _buildTopSummaryCard(),
            SizedBox(height: AppDimens.space16),
            _buildLabCategoryCard(
              title: 'Complete Blood Count (CBC)',
              children: [
                _buildLabResultItem(
                  name: 'Hemoglobin',
                  normalRange: 'Normal range: 13.5-17.5 g/dL',
                  status: 'Normal',
                  value: '13.5',
                  unit: 'g/dL',
                ),
                _buildLabResultItem(
                  name: 'White Blood Cells',
                  normalRange: 'Normal range: 4.5-11.0 ×10³/μL',
                  status: 'High ↑',
                  value: '12.8',
                  unit: '×10³/μL',
                ),
                _buildLabResultItem(
                  name: 'Platelets',
                  normalRange: 'Normal range: 150-400 ×10³/μL',
                  status: 'Normal',
                  value: '245',
                  unit: '×10³/μL',
                ),
                _buildLabResultItem(
                  name: 'Hematocrit',
                  normalRange: 'Normal range: 40-54 %',
                  status: 'Normal',
                  value: '42',
                  unit: '%',
                  isLastItem: true,
                ),
              ],
            ),
            SizedBox(height: AppDimens.space16),
            _buildLabCategoryCard(
              title: 'Metabolic Panel',
              children: [
                _buildLabResultItem(
                  name: 'Glucose',
                  normalRange: 'Normal range: 70-100 mg/dL',
                  status: 'High ↑',
                  value: '118',
                  unit: 'mg/dL',
                ),
                _buildLabResultItem(
                  name: 'Sodium',
                  normalRange: 'Normal range: 135-145 mEq/L',
                  status: 'Normal',
                  value: '138',
                  unit: 'mEq/L',
                ),
                _buildLabResultItem(
                  name: 'Potassium',
                  normalRange: 'Normal range: 3.5-5.0 mEq/L',
                  status: 'Low ↓',
                  value: '3.2',
                  unit: 'mEq/L',
                ),
                _buildLabResultItem(
                  name: 'Creatinine',
                  normalRange: 'Normal range: 0.7-1.3 mg/dL',
                  status: 'Normal',
                  value: '1.1',
                  unit: 'mg/dL',
                  isLastItem: true,
                ),
              ],
            ),
            SizedBox(height: AppDimens.space16),
            _buildLabCategoryCard(
              title: 'Liver Function Tests',
              children: [
                _buildLabResultItem(
                  name: 'ALT',
                  normalRange: 'Normal range: 7-56 U/L',
                  status: 'Normal',
                  value: '28',
                  unit: 'U/L',
                ),
                _buildLabResultItem(
                  name: 'AST',
                  normalRange: 'Normal range: 10-40 U/L',
                  status: 'Normal',
                  value: '32',
                  unit: 'U/L',
                ),
                _buildLabResultItem(
                  name: 'Bilirubin',
                  normalRange: 'Normal range: 0.3-1.2 mg/dL',
                  status: 'Normal',
                  value: '0.8',
                  unit: 'mg/dL',
                  isLastItem: true,
                ),
              ],
            ),
            SizedBox(height: AppDimens.space16),
            _buildLabCategoryCard(
              title: 'Coagulation Profile',
              children: [
                _buildLabResultItem(
                  name: 'PT/INR',
                  normalRange: 'Normal range: 11.0-13.5 sec',
                  status: 'Normal',
                  value: '12.5',
                  unit: 'sec',
                ),
                _buildLabResultItem(
                  name: 'aPTT',
                  normalRange: 'Normal range: 25-35 sec',
                  status: 'Normal',
                  value: '32',
                  unit: 'sec',
                  isLastItem: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSummaryCard() {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: AppDimens.paddingAll12,
            decoration: BoxDecoration(
              color: AppColors.infoBlue.withValues(alpha:0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.history, color: AppColors.infoBlue, size: AppDimens.iconSize),
          ),
          SizedBox(width: AppDimens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Updated',
                  style: TextStyle(
                    fontSize: AppDimens.fontSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppDimens.space4),
                Text(
                  'Feb 3, 2026 - 08:30 AM',
                  style: TextStyle(
                    fontSize: AppDimens.fontMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: AppDimens.radius8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.space12, vertical: AppDimens.space8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: AppDimens.radius8,
              ),
              child: Text(
                'View History',
                style: TextStyle(
                  color: AppColors.textMain,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimens.fontSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabCategoryCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDimens.paddingAll16,
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppDimens.fontLarge,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ),
          Divider(height: 1, color: AppColors.border),
          ...children,
        ],
      ),
    );
  }

  Widget _buildLabResultItem({
    required String name,
    required String normalRange,
    required String status,
    required String value,
    required String unit,
    bool isLastItem = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: AppDimens.paddingAll16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: AppDimens.fontMedium,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMain,
                          ),
                        ),
                        SizedBox(width: AppDimens.space8),
                        _buildStatusBadge(status),
                      ],
                    ),
                    SizedBox(height: AppDimens.space4),
                    Text(
                      normalRange,
                      style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: AppDimens.fontXLarge,
                      fontWeight: FontWeight.bold,
                      color: _getValueColor(status),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    unit,
                    style: TextStyle(
                      fontSize: AppDimens.fontSmall,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isLastItem) Divider(height: 1, color: AppColors.border),
      ],
    );
  }

  Color _getValueColor(String status) {
    if (status.contains('High')) {
      return AppColors.errorRed;
    } else if (status.contains('Low')) {
      return AppColors.warningOrange; // or another color based on design
    }
    return AppColors.textMain;
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    if (status.contains('Normal')) {
      bgColor = AppColors.successGreen.withValues(alpha:0.1);
      textColor = AppColors.successGreen;
    } else if (status.contains('High')) {
      bgColor = AppColors.errorRed.withValues(alpha:0.1);
      textColor = AppColors.errorRed;
    } else if (status.contains('Low')) {
      bgColor = AppColors.warningOrange.withValues(alpha:0.1);
      textColor = AppColors.warningOrange;
    } else {
      bgColor = AppColors.infoBlue.withValues(alpha:0.1);
      textColor = AppColors.infoBlue;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.space8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimens.radius8,
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
