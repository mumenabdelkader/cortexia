import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';
import 'package:cortexia/features/doctor/presentation/controllers/doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final DoctorCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = locator<DoctorCubit>();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final userData = await AppCache.getUserData();
    final email = userData?.email ?? '';
    _cubit.loadDoctorDetails(email);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: const CustomAppBar(title: 'Profile & Settings'),
        body: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is DoctorLoading || state is DoctorInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DoctorError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48, color: AppColors.errorRed),
                    const SizedBox(height: 12),
                    Text(
                      state.message,
                      style: TextStyle(color: AppColors.errorRed),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _loadProfile,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final doctor =
                state is DoctorLoaded ? state.doctor : null;

            return SingleChildScrollView(
              padding: AppDimens.paddingAll16,
              child: Column(
                children: [
                  _buildProfileHeader(doctor),
                  SizedBox(height: AppDimens.space16),
                  _buildInfoCard(doctor),
                  SizedBox(height: AppDimens.space16),
                  _buildProfessionalCard(doctor),
                  SizedBox(height: AppDimens.space16),
                  if (doctor?.address?.fullAddress.isNotEmpty == true)
                    _buildAddressCard(doctor!.address!),
                  if (doctor?.address?.fullAddress.isNotEmpty == true)
                    SizedBox(height: AppDimens.space16),
                  _buildSettingsCard(),
                  SizedBox(height: AppDimens.space16),
                  _buildNotificationPreferencesCard(),
                  SizedBox(height: AppDimens.space16),
                  _buildSecurityCard(),
                  SizedBox(height: AppDimens.space32),
                  _buildLogoutSection(context),
                  SizedBox(height: AppDimens.space32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ─── Profile Header ──────────────────────────────────────────────────────────

  Widget _buildProfileHeader(DoctorModel? doctor) {
    final initials = doctor?.name
        ?.split(' ')
        .take(2)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
        .join() ?? '?';

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
            backgroundColor: AppColors.infoBlue.withValues(alpha: 0.1),
            child: Text(
              initials,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.infoBlue,
              ),
            ),
          ),
          SizedBox(height: AppDimens.space16),
          Text(
            doctor?.displayName ?? 'Loading...',
            style: TextStyle(
              fontSize: AppDimens.fontLarge,
              fontWeight: FontWeight.bold,
              color: AppColors.textMain,
            ),
          ),
          SizedBox(height: AppDimens.space4),
          if (doctor?.specialty != null)
            Text(
              doctor!.specialty!,
              style: TextStyle(
                fontSize: AppDimens.fontMedium,
                color: AppColors.textSecondary,
              ),
            ),
          SizedBox(height: AppDimens.space12),
          // ID Badge
          if (doctor?.id != null)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.space12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.infoBlue.withValues(alpha: 0.08),
                borderRadius: AppDimens.radius8,
                border: Border.all(
                    color: AppColors.infoBlue.withValues(alpha: 0.3)),
              ),
              child: Text(
                doctor!.id!,
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  fontWeight: FontWeight.w600,
                  color: AppColors.infoBlue,
                ),
              ),
            ),
          SizedBox(height: AppDimens.space12),
          // Role + Department chips
          Wrap(
            spacing: 8,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              if (doctor?.department != null)
                _buildChip(Icons.local_hospital_outlined, doctor!.department!,
                    Colors.teal),
              if (doctor?.roleLabel != null && doctor?.roleLabel != 'N/A')
                _buildChip(Icons.badge_outlined, doctor!.roleLabel, Colors.indigo),
              if (doctor?.shiftLabel != null && doctor?.shiftLabel != 'N/A')
                _buildChip(Icons.schedule_outlined, '${doctor!.shiftLabel} Shift',
                    Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  // ─── Contact Info Card ────────────────────────────────────────────────────

  Widget _buildInfoCard(DoctorModel? doctor) {
    return _buildSectionCard(
      title: 'Contact Information',
      children: [
        _buildInfoRow(Icons.email_outlined, 'Email',
            doctor?.email ?? '—'),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildInfoRow(Icons.phone_outlined, 'Phone',
            doctor?.phoneNumber ?? '—'),
        if (doctor?.genderLabel != null) ...[
          Divider(height: AppDimens.space24, color: AppColors.border),
          _buildInfoRow(
              Icons.person_outline, 'Gender', doctor!.genderLabel),
        ],
        if (doctor?.dateOfBirth != null) ...[
          Divider(height: AppDimens.space24, color: AppColors.border),
          _buildInfoRow(Icons.cake_outlined, 'Date of Birth',
              _formatDate(doctor!.dateOfBirth!)),
        ],
      ],
    );
  }

  // ─── Professional Card ────────────────────────────────────────────────────

  Widget _buildProfessionalCard(DoctorModel? doctor) {
    return _buildSectionCard(
      title: 'Professional Details',
      children: [
        if (doctor?.specialty != null) ...[
          _buildInfoRow(
              Icons.medical_services_outlined, 'Specialty', doctor!.specialty!),
          Divider(height: AppDimens.space24, color: AppColors.border),
        ],
        if (doctor?.department != null) ...[
          _buildInfoRow(
              Icons.business_outlined, 'Department', doctor!.department!),
          Divider(height: AppDimens.space24, color: AppColors.border),
        ],
        if (doctor?.experienceYears != null) ...[
          _buildInfoRow(Icons.workspace_premium_outlined, 'Experience',
              '${doctor!.experienceYears} years'),
          Divider(height: AppDimens.space24, color: AppColors.border),
        ],
        _buildInfoRow(Icons.badge_outlined, 'Role',
            doctor?.roleLabel ?? '—'),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildInfoRow(Icons.schedule_outlined, 'Shift',
            doctor?.shiftLabel != null ? '${doctor!.shiftLabel} Shift' : '—'),
      ],
    );
  }

  // ─── Address Card ─────────────────────────────────────────────────────────

  Widget _buildAddressCard(DoctorAddress address) {
    return _buildSectionCard(
      title: 'Address',
      children: [
        if (address.street != null)
          _buildInfoRow(Icons.signpost_outlined, 'Street', address.street!),
        if (address.city != null) ...[
          Divider(height: AppDimens.space24, color: AppColors.border),
          _buildInfoRow(Icons.location_city_outlined, 'City', address.city!),
        ],
        if (address.state != null) ...[
          Divider(height: AppDimens.space24, color: AppColors.border),
          _buildInfoRow(Icons.map_outlined, 'State', address.state!),
        ],
        if (address.zipCode != null) ...[
          Divider(height: AppDimens.space24, color: AppColors.border),
          _buildInfoRow(
              Icons.markunread_mailbox_outlined, 'Zip Code', address.zipCode!),
        ],
      ],
    );
  }

  // ─── Settings Card ────────────────────────────────────────────────────────

  Widget _buildSettingsCard() {
    return _buildSectionCard(
      title: 'App Settings',
      children: [
        _buildToggleRow(
            Icons.dark_mode_outlined, 'Dark Mode', 'Enable dark theme', false),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildToggleRow(Icons.notifications_active_outlined,
            'Push Notifications', 'Receive alerts and updates', true),
        Divider(height: AppDimens.space24, color: AppColors.border),
        _buildToggleRow(Icons.volume_up_outlined, 'Critical Alerts Sound',
            'Audio alerts for critical events', true),
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

  // ─── Helpers ─────────────────────────────────────────────────────────────

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
    } catch (_) {
      return isoDate;
    }
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
              Text(label,
                  style:
                      TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 2),
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
      IconData icon, String title, String subtitle, bool initialValue) {
    return Row(
      children: [
        Container(
          padding: AppDimens.paddingAll8,
          decoration:
              BoxDecoration(color: AppColors.scaffoldBg, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.textSecondary, size: 20),
        ),
        SizedBox(width: AppDimens.space16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: AppDimens.fontMedium,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMain)),
              Text(subtitle,
                  style:
                      TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Switch(
          value: initialValue,
          onChanged: (val) {},
          activeThumbColor: AppColors.infoBlue,
          activeTrackColor: AppColors.infoBlue.withValues(alpha: 0.3),
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
            Text(title,
                style: TextStyle(
                    fontSize: AppDimens.fontMedium,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMain)),
            Checkbox(
                value: initialValue,
                onChanged: (val) {},
                activeColor: AppColors.infoBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
          ],
        ),
      ),
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
            Text(label,
                style: TextStyle(
                    fontSize: AppDimens.fontMedium,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMain)),
            const Spacer(),
            Icon(Icons.chevron_right, color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutSection(BuildContext context) {
    return Column(
      children: [
        Text('App Version 1.0.0 (Build 42)',
            style: TextStyle(fontSize: 12, color: AppColors.textLight)),
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
                Text('Log Out',
                    style: TextStyle(
                        fontSize: AppDimens.fontMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColors.errorRed)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
