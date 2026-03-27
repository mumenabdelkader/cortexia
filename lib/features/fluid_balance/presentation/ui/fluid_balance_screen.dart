import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';

class FluidBalanceScreen extends StatelessWidget {
  const FluidBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Fluid Balance Tracker'),
      body: SingleChildScrollView(
        padding: AppDimens.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientHeader(),
            SizedBox(height: AppDimens.space16),
            _buildSummaryCards(),
            SizedBox(height: AppDimens.space24),
            _buildFluidInputSection(context),
            SizedBox(height: AppDimens.space24),
            _buildFluidOutputSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Anderson',
                style: TextStyle(
                  fontSize: AppDimens.fontLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                'PT-2024-1547 • ICU-101',
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Text(
            'Feb 3, 2026',
            style: TextStyle(
              fontSize: AppDimens.fontSmall,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            title: 'Total Input',
            value: '2050',
            unit: 'mL',
            icon: Icons.arrow_downward,
            color: AppColors.infoBlue,
          ),
        ),
        SizedBox(width: AppDimens.space8),
        Expanded(
          child: _buildSummaryCard(
            title: 'Total Output',
            value: '1300',
            unit: 'mL',
            icon: Icons.arrow_upward,
            color: AppColors.warningOrange,
          ),
        ),
        SizedBox(width: AppDimens.space8),
        Expanded(
          child: _buildSummaryCard(
            title: 'Net Balance',
            value: '+750',
            unit: 'mL',
            icon: Icons.waves,
            color: AppColors.successGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimens.space16, horizontal: AppDimens.space8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: AppDimens.iconSize),
          SizedBox(height: AppDimens.space8),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: AppDimens.fontTitle,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFluidInputSection(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.water_drop, color: AppColors.infoBlue, size: AppDimens.iconSize),
                  SizedBox(width: AppDimens.space8),
                  Text(
                    'Fluid Input',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textMain,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                borderRadius: AppDimens.radius8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.space12, vertical: AppDimens.space8),
                  decoration: BoxDecoration(
                    color: AppColors.infoBlue.withValues(alpha:0.1),
                    borderRadius: AppDimens.radius8,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: AppColors.infoBlue, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Add',
                        style: TextStyle(
                          color: AppColors.infoBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimens.fontSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          _buildInputRecordCard(
            title: 'IV Normal Saline',
            time: '08:00',
            badgeText: 'IV',
            amount: '1000 mL',
          ),
          SizedBox(height: AppDimens.space12),
          _buildInputRecordCard(
            title: 'Oral Fluids',
            time: '10:30',
            badgeText: 'PO',
            amount: '500 mL',
          ),
          SizedBox(height: AppDimens.space12),
          _buildInputRecordCard(
            title: 'IV Medications',
            time: '12:00',
            badgeText: 'IV',
            amount: '250 mL',
          ),
          SizedBox(height: AppDimens.space12),
          _buildInputRecordCard(
            title: 'Oral Fluids',
            time: '14:00',
            badgeText: 'PO',
            amount: '300 mL',
          ),
          SizedBox(height: AppDimens.space16),
          _buildAddRecordForm(context, isInput: true),
        ],
      ),
    );
  }

  Widget _buildFluidOutputSection(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.water_drop_outlined, color: AppColors.warningOrange, size: AppDimens.iconSize),
                  SizedBox(width: AppDimens.space8),
                  Text(
                    'Fluid Output',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textMain,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                borderRadius: AppDimens.radius8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.space12, vertical: AppDimens.space8),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha:0.1),
                    borderRadius: AppDimens.radius8,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: AppColors.warningOrange, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Add',
                        style: TextStyle(
                          color: AppColors.warningOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimens.fontSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          _buildOutputRecordCard(
            title: 'Urine Output',
            time: '08:00-12:00',
            colorNote: 'Color: Clear yellow',
            amount: '850 mL',
          ),
          SizedBox(height: AppDimens.space12),
          _buildOutputRecordCard(
            title: 'Surgical Drain',
            time: '14:00',
            colorNote: 'Color: Serosanguinous',
            amount: '150 mL',
          ),
          SizedBox(height: AppDimens.space16),
          _buildAddRecordForm(context, isInput: false),
        ],
      ),
    );
  }

  Widget _buildInputRecordCard({
    required String title,
    required String time,
    required String badgeText,
    required String amount,
  }) {
    return Container(
      padding: AppDimens.paddingAll12,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: AppDimens.radius12,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                time,
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.space8, vertical: AppDimens.space4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: AppDimens.radius8,
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Text(
                amount,
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.infoBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOutputRecordCard({
    required String title,
    required String time,
    required String colorNote,
    required String amount,
  }) {
    return Container(
      padding: AppDimens.paddingAll12,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: AppDimens.radius12,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                time,
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                colorNote,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.warningOrange,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: AppDimens.fontMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.warningOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRecordForm(BuildContext context, {required bool isInput}) {
    final title = isInput ? 'Add New Input' : 'Add New Output';
    final buttonText = isInput ? 'Add Input Record' : 'Add Output Record';
    final themeColor = isInput ? AppColors.infoBlue : AppColors.warningOrange;

    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: isInput ? AppColors.infoBlue.withValues(alpha:0.05) : AppColors.warningOrange.withValues(alpha:0.05),
        borderRadius: AppDimens.radius12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppDimens.fontMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: AppDimens.space12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  hintText: 'Type',
                  fillColor: AppColors.white,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                flex: 1,
                child: CustomTextFormField(
                  hintText: 'Amount (mL)',
                  keyboardType: TextInputType.number,
                  fillColor: AppColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  hintText: isInput ? 'Route' : 'Characteristics/Color',
                  fillColor: AppColors.white,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Expanded(
                flex: 1,
                child: CustomTextFormField(
                  hintText: 'Time',
                  fillColor: AppColors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          CustomElevatedButton(
            text: buttonText,
            onPressed: () {},
            height: AppDimens.buttonHeight,
            backgroundColor: themeColor,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
