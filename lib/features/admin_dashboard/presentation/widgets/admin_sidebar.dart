import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/routing/routes.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:flutter/material.dart';

/// Navigation item data model for the admin sidebar.
class AdminNavItem {
  final String label;
  final IconData icon;
  final int index;

  const AdminNavItem({
    required this.label,
    required this.icon,
    required this.index,
  });
}

/// The complete list of admin navigation items.
const List<AdminNavItem> adminNavItems = [
  AdminNavItem(label: 'Overview', icon: Icons.dashboard_outlined, index: 0),
  AdminNavItem(label: 'Users', icon: Icons.people_outline, index: 1),
  AdminNavItem(
    label: 'Roles',
    icon: Icons.admin_panel_settings_outlined,
    index: 2,
  ),
  AdminNavItem(label: 'Rooms', icon: Icons.meeting_room_outlined, index: 3),
  AdminNavItem(label: 'Beds', icon: Icons.bed_outlined, index: 4),
  AdminNavItem(
    label: 'Doctors',
    icon: Icons.medical_services_outlined,
    index: 5,
  ),
  AdminNavItem(
    label: 'Nurses',
    icon: Icons.medical_information_outlined,
    index: 6,
  ),
  AdminNavItem(label: 'Audit Logs', icon: Icons.history_outlined, index: 7),
];

/// Permanent sidebar for desktop/tablet layouts.
class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkBlue, Color(0xFF003580)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Brand header
          _buildHeader(context),
          const SizedBox(height: 8),
          // Nav items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: adminNavItems.length,
              itemBuilder: (_, i) => _buildNavTile(adminNavItems[i], context),
            ),
          ),
          // Bottom: user info + logout
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo mark
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: const Image(
              image: AssetImage("assets/images/small_logo.png"),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Cortexia',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Admin Dashboard',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile(AdminNavItem item, BuildContext context) {
    final isSelected = selectedIndex == item.index;
    return GestureDetector(
      onTap: () => onItemSelected(item.index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.white.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: isSelected
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.6),
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.65),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: GestureDetector(
        onTap: () => _handleLogout(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.red.shade300, size: 20),
              const SizedBox(width: 12),
              Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red.shade300,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    await AppCache.clearUserData();
    if (context.mounted) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(Routes.loginScreen, (_) => false);
    }
  }
}
