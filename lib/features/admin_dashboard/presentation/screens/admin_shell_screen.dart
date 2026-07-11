import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/responsive/responsive.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_audit_logs_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_beds_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_dashboard_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_roles_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_rooms_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_users_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_audit_logs_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_beds_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_overview_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_roles_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_rooms_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_users_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_doctors_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/screens/admin_nurses_screen.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_doctors_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_nurses_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Admin dashboard shell — provides responsive layout (sidebar on desktop,
/// drawer on mobile) and hosts all admin sub-screens in an IndexedStack.
class AdminShellScreen extends StatefulWidget {
  const AdminShellScreen({super.key});

  @override
  State<AdminShellScreen> createState() => _AdminShellScreenState();
}

class _AdminShellScreenState extends State<AdminShellScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    AdminOverviewScreen(),
    AdminUsersScreen(),
    AdminRolesScreen(),
    AdminRoomsScreen(),
    AdminBedsScreen(),
    AdminDoctorsScreen(),
    AdminNursesScreen(),
    AdminAuditLogsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminDashboardCubit>(
            create: (_) => locator<AdminDashboardCubit>()),
        BlocProvider<AdminUsersCubit>(
            create: (_) => locator<AdminUsersCubit>()),
        BlocProvider<AdminRolesCubit>(
            create: (_) => locator<AdminRolesCubit>()),
        BlocProvider<AdminRoomsCubit>(
            create: (_) => locator<AdminRoomsCubit>()),
        BlocProvider<AdminBedsCubit>(
            create: (_) => locator<AdminBedsCubit>()),
        BlocProvider<AdminAuditLogsCubit>(
            create: (_) => locator<AdminAuditLogsCubit>()),
        BlocProvider<AdminDoctorsCubit>(
            create: (_) => locator<AdminDoctorsCubit>()),
        BlocProvider<AdminNursesCubit>(
            create: (_) => locator<AdminNursesCubit>()),
      ],
      child: Responsive(
        desktop: _buildDesktopLayout(),
        tablet: _buildTabletLayout(),
        mobile: _buildMobileLayout(),
      ),
    );
  }

  // ── Desktop: permanent sidebar + content ──────────────────────────────────

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Row(
        children: [
          AdminSidebar(
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemSelected,
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  // ── Tablet: collapsible sidebar via NavigationRail ────────────────────────

  Widget _buildTabletLayout() {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: AppColors.darkBlue,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemSelected,
            labelType: NavigationRailLabelType.all,
            destinations: adminNavItems
                .map(
                  (item) => NavigationRailDestination(
                    icon: Icon(item.icon,
                        color: Colors.white.withValues(alpha: 0.6)),
                    selectedIcon:
                        Icon(item.icon, color: Colors.white),
                    label: Text(
                      item.label,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10),
                    ),
                  ),
                )
                .toList(),
            selectedIconTheme:
                const IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(
                color: Colors.white.withValues(alpha: 0.6)),
            indicatorColor: Colors.white.withValues(alpha: 0.15),
          ),
          const VerticalDivider(thickness: 0, width: 0),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  // ── Mobile: drawer ────────────────────────────────────────────────────────

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          adminNavItems[_selectedIndex].label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: AdminSidebar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            _onItemSelected(index);
            Navigator.of(context).pop(); // close drawer
          },
        ),
      ),
      body: _buildContent(),
    );
  }

  // ── Content ───────────────────────────────────────────────────────────────

  Widget _buildContent() {
    return IndexedStack(
      index: _selectedIndex,
      children: _screens,
    );
  }

  void _onItemSelected(int index) {
    setState(() => _selectedIndex = index);
  }
}
