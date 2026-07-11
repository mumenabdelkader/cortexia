import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/user_with_roles_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_roles_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_users_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_confirm_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_form_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<AdminUsersCubit>().getUsersWithRoles();
    context.read<AdminRolesCubit>().getRoles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminUsersCubit, AdminUsersState>(
      listener: (context, state) {
        if (state is AdminUsersSuccess &&
            state.operation != kGetUsersWithRoles) {
          final msgs = {
            kAssignRole: 'Role assigned successfully!',
            kRemoveRole: 'Role removed successfully!',
            kToggleUserStatus: 'User status updated!',
            kForceResetPassword: 'Password reset successfully!',
            kCreateAdmin: 'Admin account created!',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msgs[state.operation] ?? 'Action completed!'),
              backgroundColor: AppColors.successGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          context.read<AdminUsersCubit>().getUsersWithRoles();
        }
        if (state is AdminUsersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminSectionHeader(
                title: 'Users & Roles',
                subtitle: 'Manage system users, roles, and permissions',
                actionLabel: 'Create Admin',
                actionIcon: Icons.admin_panel_settings_outlined,
                onAction: _showCreateAdminDialog,
              ),
              const SizedBox(height: 20),
              // Search
              TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search users by username...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  fillColor: AppColors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              if (state is AdminUsersLoading || state is AdminUsersInitial)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child:
                        CircularProgressIndicator(color: AppColors.primaryBlue),
                  ),
                )
              else if (state is AdminUsersError)
                _buildError(state.message)
              else if (state is AdminUsersSuccess &&
                  state.operation == kGetUsersWithRoles)
                _buildUsersList(state.data as List<UserWithRolesModel>),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUsersList(List<UserWithRolesModel> users) {
    final filtered = _searchQuery.isEmpty
        ? users
        : users
            .where((u) => u.userName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('No users found.',
              style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filtered.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: AppColors.divider),
        itemBuilder: (_, i) => _buildUserTile(filtered[i]),
      ),
    );
  }

  Widget _buildUserTile(UserWithRolesModel user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
            child: Text(
              user.userName.isNotEmpty
                  ? user.userName[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          // Username + roles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMain,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: user.roles
                      .map((r) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.infoBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(r,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.infoBlue,
                                    fontWeight: FontWeight.w500)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          // Actions
          PopupMenuButton<String>(
            onSelected: (action) =>
                _handleUserAction(action, user),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: 'assign',
                  child: Row(children: [
                    Icon(Icons.add_moderator_outlined, size: 16),
                    SizedBox(width: 8),
                    Text('Assign Role'),
                  ])),
              const PopupMenuItem(
                  value: 'remove',
                  child: Row(children: [
                    Icon(Icons.remove_moderator_outlined, size: 16),
                    SizedBox(width: 8),
                    Text('Remove Role'),
                  ])),
              const PopupMenuItem(
                  value: 'toggle',
                  child: Row(children: [
                    Icon(Icons.toggle_on_outlined, size: 16),
                    SizedBox(width: 8),
                    Text('Toggle Status'),
                  ])),
              const PopupMenuItem(
                  value: 'reset',
                  child: Row(children: [
                    Icon(Icons.lock_reset_outlined, size: 16),
                    SizedBox(width: 8),
                    Text('Reset Password'),
                  ])),
            ],
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.more_vert,
                  size: 18, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void _handleUserAction(String action, UserWithRolesModel user) {
    switch (action) {
      case 'assign':
        _showAssignRoleDialog(user);
        break;
      case 'remove':
        _showRemoveRoleDialog(user);
        break;
      case 'toggle':
        _confirmToggleStatus(user);
        break;
      case 'reset':
        _showResetPasswordDialog(user);
        break;
    }
  }

  void _showAssignRoleDialog(UserWithRolesModel user) {
    final rolesState = context.read<AdminRolesCubit>().state;
    final availableRoles = rolesState is AdminRolesSuccess
        ? (rolesState.data as List<dynamic>)
            .map((e) => (e as dynamic).name as String)
            .toList()
        : <String>[];

    String? selectedRole;
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminUsersCubit>(),
        child: StatefulBuilder(
          builder: (ctx2, setS) => AdminFormDialog(
            title: 'Assign Role to ${user.userName}',
            titleIcon: Icons.add_moderator_outlined,
            submitLabel: 'Assign',
            onSubmit: () {
              if (selectedRole == null) return;
              ctx2.read<AdminUsersCubit>().assignRole(
                    userId: user.userId,
                    roleName: selectedRole!,
                  );
              Navigator.of(ctx2).pop();
            },
            formContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Role',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: selectedRole,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.shield_outlined),
                  ),
                  hint: const Text('Choose a role'),
                  items: availableRoles
                      .map((r) =>
                          DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setS(() => selectedRole = v),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRemoveRoleDialog(UserWithRolesModel user) {
    String? selectedRole =
        user.roles.isNotEmpty ? user.roles.first : null;
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminUsersCubit>(),
        child: StatefulBuilder(
          builder: (ctx2, setS) => AdminFormDialog(
            title: 'Remove Role from ${user.userName}',
            titleIcon: Icons.remove_moderator_outlined,
            submitLabel: 'Remove',
            onSubmit: () {
              if (selectedRole == null) return;
              ctx2.read<AdminUsersCubit>().removeRole(
                    userId: user.userId,
                    roleName: selectedRole!,
                  );
              Navigator.of(ctx2).pop();
            },
            formContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Role to Remove',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: selectedRole,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.shield_outlined),
                  ),
                  items: user.roles
                      .map((r) =>
                          DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setS(() => selectedRole = v),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmToggleStatus(UserWithRolesModel user) async {
    final confirmed = await AdminConfirmDialog.show(
      context: context,
      title: 'Toggle User Status',
      message:
          'Are you sure you want to toggle the status for "${user.userName}"?',
      confirmLabel: 'Toggle',
      confirmColor: AppColors.warningOrange,
      icon: Icons.toggle_on_outlined,
    );
    if (confirmed && mounted) {
      context.read<AdminUsersCubit>().toggleUserStatus(user.userId);
    }
  }

  void _showResetPasswordDialog(UserWithRolesModel user) {
    final pwController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminUsersCubit>(),
        child: AdminFormDialog(
          title: 'Reset Password',
          titleIcon: Icons.lock_reset_outlined,
          submitLabel: 'Reset',
          onSubmit: () {
            final pw = pwController.text.trim();
            if (pw.isEmpty) return;
            ctx.read<AdminUsersCubit>().forceResetPassword(
                  userId: user.userId,
                  newPassword: pw,
                );
            Navigator.of(ctx).pop();
          },
          formContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User: ${user.userName}',
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 16),
              const Text('New Password',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 8),
              TextField(
                controller: pwController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter new password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateAdminDialog() {
    final emailCtrl = TextEditingController();
    final usernameCtrl = TextEditingController();
    final fullNameCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminUsersCubit>(),
        child: AdminFormDialog(
          title: 'Create Admin Account',
          titleIcon: Icons.admin_panel_settings_outlined,
          submitLabel: 'Create Admin',
          onSubmit: () {
            ctx.read<AdminUsersCubit>().createAdmin(
                  email: emailCtrl.text.trim(),
                  password: passwordCtrl.text.trim(),
                  username: usernameCtrl.text.trim(),
                  fullName: fullNameCtrl.text.trim(),
                );
            Navigator.of(ctx).pop();
          },
          formContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _formField('Full Name', fullNameCtrl,
                  Icons.badge_outlined, 'e.g. John Doe'),
              const SizedBox(height: 14),
              _formField('Username', usernameCtrl,
                  Icons.person_outline, 'e.g. john_doe'),
              const SizedBox(height: 14),
              _formField('Email', emailCtrl,
                  Icons.email_outlined, 'admin@hospital.com',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _formField('Password', passwordCtrl,
                  Icons.lock_outline, 'Min 8 characters',
                  obscure: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formField(String label, TextEditingController ctrl, IconData icon,
      String hint,
      {bool obscure = false, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,
              size: 48, color: AppColors.errorRed),
          const SizedBox(height: 12),
          Text(message,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () =>
                context.read<AdminUsersCubit>().getUsersWithRoles(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
