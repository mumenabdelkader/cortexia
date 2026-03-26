import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Profile & Settings'),
      body: SingleChildScrollView(
        padding: AppDimens.paddingAll16,
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: AppDimens.space16),
            _buildStatCardsRow(),
            SizedBox(height: AppDimens.space24),
            _buildContactInfoCard(),
            SizedBox(height: AppDimens.space24),
            _buildSettingsCard(),
            SizedBox(height: AppDimens.space24),
            _buildNotificationPreferencesCard(),
            SizedBox(height: AppDimens.space24),
            _buildSecurityCard(),
            SizedBox(height: AppDimens.space32),
            _buildLogoutSection(context),
            SizedBox(height: AppDimens.space32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: AppDimens.paddingAll24,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0x1A0066CC),
            child: Icon(
              Icons.person,
              size: 50,
              color: AppColors.infoBlue,
            ), // Placeholder for image
          ),
          SizedBox(height: AppDimens.space16),
          Text(
            'Dr. Sarah Johnson',
            style: TextStyle(
              fontSize: AppDimens.fontLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            'Internal Medicine',
            style: TextStyle(
              fontSize: AppDimens.fontMedium,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppDimens.space12),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.space12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0x1A0066CC),
              borderRadius: AppDimens.radius8,
              border: Border.all(color: AppColors.infoBlue.withValues(alpha:0.3)),
            ),
            child: Text(
              'DR-2024-001',
              style: TextStyle(
                fontSize: AppDimens.fontSmall,
                fontWeight: FontWeight.w600,
                color: AppColors.infoBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCardsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            count: '24',
            label: 'Active Patients',
            icon: Icons.people_outline,
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: _buildStatCard(
            count: '7',
            label: 'Pending Alerts',
            icon: Icons.notifications_none,
          ),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: _buildStatCard(
            count: '12',
            label: 'Tasks Today',
            icon: Icons.check_circle_outline,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String count,
    required String label,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDimens.space16,
        horizontal: AppDimens.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.infoBlue, size: 28),
          SizedBox(height: AppDimens.space12),
          Text(
            count,
            style: TextStyle(
              fontSize: AppDimens.fontXXLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return _buildSectionCard(
      title: 'Contact Information',
      children: [
        _buildInfoRow(
          Icons.email_outlined,
          'Email',
          'sarah.johnson@hospital.com',
        ),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildInfoRow(Icons.phone_outlined, 'Phone', '+1 (555) 123-4567'),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildInfoRow(
          Icons.business_outlined,
          'Department',
          'Critical Care Unit',
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: AppDimens.paddingAll8,
          decoration: BoxDecoration(
            color: AppColors.scaffoldBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.textSecondary, size: 20),
        ),
        SizedBox(width: AppDimens.space16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard() {
    return _buildSectionCard(
      title: 'App Settings',
      children: [
        _buildToggleRow(
          Icons.dark_mode_outlined,
          'Dark Mode',
          'Enable dark theme',
          false,
        ),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildToggleRow(
          Icons.notifications_active_outlined,
          'Push Notifications',
          'Receive alerts and updates',
          true,
        ),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildToggleRow(
          Icons.volume_up_outlined,
          'Critical Alerts Sound',
          'Audio alerts for critical events',
          true,
        ),
      ],
    );
  }

  Widget _buildNotificationPreferencesCard() {
    return _buildSectionCard(
      title: 'Notification Preferences',
      children: [
        _buildCheckboxRow('Lab Results', true),
        _buildCheckboxRow('Medication Reminders', true),
        _buildCheckboxRow('Vital Sign Alerts', true),
        _buildCheckboxRow('Patient Updates', false),
      ],
    );
  }

  Widget _buildSecurityCard() {
    return _buildSectionCard(
      title: 'Security',
      children: [
        _buildActionButton(Icons.lock_outline, 'Change Password'),
        SizedBox(height: AppDimens.space12),
        _buildActionButton(Icons.edit_outlined, 'Edit Profile'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      borderRadius: AppDimens.radius12,
      child: Container(
        padding: AppDimens.paddingAll16,
        decoration: BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: AppDimens.radius12,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textMain, size: 20),
            SizedBox(width: AppDimens.space12),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimens.fontMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.textMain,
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: AppDimens.paddingAll20,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppDimens.fontLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: AppDimens.space20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleRow(
    IconData icon,
    String title,
    String subtitle,
    bool initialValue,
  ) {
    return Row(
      children: [
        Container(
          padding: AppDimens.paddingAll8,
          decoration: BoxDecoration(
            color: AppColors.scaffoldBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.textSecondary, size: 20),
        ),
        SizedBox(width: AppDimens.space16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMain,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        Switch(
          value: initialValue,
          onChanged: (val) {},
          activeThumbColor: AppColors.infoBlue,
          activeTrackColor: AppColors.infoBlue.withValues(alpha:0.3),
        ),
      ],
    );
  }

  Widget _buildCheckboxRow(String title, bool initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space12,
          vertical: AppDimens.space4,
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBg,
          borderRadius: AppDimens.radius12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: AppDimens.fontMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.textMain,
              ),
            ),
            Checkbox(
              value: initialValue,
              onChanged: (val) {},
              activeColor: AppColors.infoBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'App Version 1.0.0 (Build 42)',
          style: TextStyle(fontSize: 12, color: AppColors.textLight),
        ),
        SizedBox(height: AppDimens.space16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              AppCache.clearUserData();
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              padding: AppDimens.paddingAll16,
              shape: RoundedRectangleBorder(
                borderRadius: AppDimens.radius12,
                side: BorderSide(color: AppColors.errorRed),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: AppColors.errorRed),
                SizedBox(width: AppDimens.space8),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: AppDimens.fontMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
