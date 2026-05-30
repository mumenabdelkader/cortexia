import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/role_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_roles_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_confirm_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_form_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminRolesScreen extends StatefulWidget {
  const AdminRolesScreen({super.key});

  @override
  State<AdminRolesScreen> createState() => _AdminRolesScreenState();
}

class _AdminRolesScreenState extends State<AdminRolesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminRolesCubit>().getRoles();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminRolesCubit, AdminRolesState>(
      listener: (context, state) {
        if (state is AdminRolesSuccess &&
            state.operation != kGetRoles) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.operation == kCreateRole
                  ? 'Role created successfully!'
                  : 'Role deleted successfully!'),
              backgroundColor: AppColors.successGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          // Reload list after action
          context.read<AdminRolesCubit>().getRoles();
        }
        if (state is AdminRolesError) {
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
                title: 'Roles Management',
                subtitle: 'Manage system roles and permissions',
                actionLabel: 'Create Role',
                actionIcon: Icons.add,
                onAction: () => _showCreateRoleDialog(),
              ),
              const SizedBox(height: 24),
              if (state is AdminRolesLoading || state is AdminRolesInitial)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child:
                        CircularProgressIndicator(color: AppColors.primaryBlue),
                  ),
                )
              else if (state is AdminRolesError)
                _buildError(state.message)
              else if (state is AdminRolesSuccess &&
                  state.operation == kGetRoles)
                _buildRolesList(state.data as List<RoleModel>),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRolesList(List<RoleModel> roles) {
    if (roles.isEmpty) {
      return const Center(
        child: Text('No roles found.',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return Column(
      children: roles
          .map((role) => _buildRoleCard(role))
          .toList(),
    );
  }

  Widget _buildRoleCard(RoleModel role) {
    final roleColor = _getRoleColor(role.name);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.shield_outlined, color: roleColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ID: ${role.id.substring(0, 8)}...',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          // Delete button
          IconButton(
            onPressed: () => _confirmDeleteRole(role),
            icon: const Icon(Icons.delete_outline, color: AppColors.errorRed),
            tooltip: 'Delete Role',
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String name) {
    switch (name.toLowerCase()) {
      case 'admin':
        return AppColors.primaryBlue;
      case 'doctor':
        return AppColors.successGreen;
      case 'nurse':
        return AppColors.warningOrange;
      default:
        return AppColors.infoBlue;
    }
  }

  void _showCreateRoleDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AdminRolesCubit>(),
        child: StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AdminFormDialog(
              title: 'Create New Role',
              titleIcon: Icons.shield_outlined,
              submitLabel: 'Create',
              isLoading:
                  ctx.read<AdminRolesCubit>().state is AdminRolesLoading,
              onSubmit: () {
                final name = controller.text.trim();
                if (name.isEmpty) return;
                ctx.read<AdminRolesCubit>().createRole(name);
                Navigator.of(ctx).pop();
              },
              formContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Role Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Pharmacist',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.label_outline),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmDeleteRole(RoleModel role) async {
    final confirmed = await AdminConfirmDialog.show(
      context: context,
      title: 'Delete Role',
      message:
          'Are you sure you want to delete the "${role.name}" role? This action cannot be undone.',
      confirmLabel: 'Delete',
      icon: Icons.delete_outline,
    );
    if (confirmed && mounted) {
      context.read<AdminRolesCubit>().deleteRole(role.id);
    }
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
            onPressed: () => context.read<AdminRolesCubit>().getRoles(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
