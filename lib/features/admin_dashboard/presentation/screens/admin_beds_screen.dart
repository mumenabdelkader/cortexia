import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_beds_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_confirm_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_form_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBedsScreen extends StatefulWidget {
  const AdminBedsScreen({super.key});

  @override
  State<AdminBedsScreen> createState() => _AdminBedsScreenState();
}

class _AdminBedsScreenState extends State<AdminBedsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBedsCubit, AdminBedsState>(
      listener: (context, state) {
        if (state is AdminBedsSuccess) {
          final msgs = {
            kCreateBed: 'Bed created successfully!',
            kUpdateBed: 'Bed updated successfully!',
            kDeleteBed: 'Bed deleted successfully!',
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
        }
        if (state is AdminBedsError) {
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
                title: 'Beds Management',
                subtitle: 'Create, update, and delete hospital beds',
                actionLabel: 'Create Bed',
                actionIcon: Icons.add,
                onAction: _showCreateBedDialog,
              ),
              const SizedBox(height: 24),
              if (state is AdminBedsLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(
                        color: AppColors.primaryBlue),
                  ),
                )
              else
                _buildManagementPanel(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildManagementPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bed Operations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Use the actions below to manage bed records.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _actionTile(
                icon: Icons.add_circle_outline,
                label: 'Create Bed',
                subtitle: 'Add a new bed to a room',
                color: AppColors.primaryBlue,
                onTap: _showCreateBedDialog,
              ),
              _actionTile(
                icon: Icons.edit_outlined,
                label: 'Update Bed',
                subtitle: 'Modify bed number or status',
                color: AppColors.warningOrange,
                onTap: _showUpdateBedDialog,
              ),
              _actionTile(
                icon: Icons.delete_outline,
                label: 'Delete Bed',
                subtitle: 'Remove a bed by ID',
                color: AppColors.errorRed,
                onTap: _showDeleteBedDialog,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(label,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  void _showCreateBedDialog() {
    final bedNumCtrl = TextEditingController();
    final roomIdCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminBedsCubit>(),
        child: AdminFormDialog(
          title: 'Create New Bed',
          titleIcon: Icons.bed_outlined,
          submitLabel: 'Create',
          onSubmit: () {
            ctx.read<AdminBedsCubit>().createBed(
                  roomId: roomIdCtrl.text.trim(),
                  bedNumber: bedNumCtrl.text.trim(),
                );
            Navigator.of(ctx).pop();
          },
          formContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldLabel('Room ID'),
              const SizedBox(height: 6),
              TextField(
                controller: roomIdCtrl,
                decoration: const InputDecoration(
                  hintText: 'e.g. room-uuid',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.meeting_room_outlined),
                ),
              ),
              const SizedBox(height: 14),
              _fieldLabel('Bed Number'),
              const SizedBox(height: 6),
              TextField(
                controller: bedNumCtrl,
                decoration: const InputDecoration(
                  hintText: 'e.g. BED-001',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.bed_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateBedDialog() {
    final bedIdCtrl = TextEditingController();
    final bedNumCtrl = TextEditingController();
    int selectedStatus = 0;

    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminBedsCubit>(),
        child: StatefulBuilder(
          builder: (ctx2, setS) => AdminFormDialog(
            title: 'Update Bed',
            titleIcon: Icons.edit_outlined,
            submitLabel: 'Update',
            onSubmit: () {
              ctx2.read<AdminBedsCubit>().updateBed(
                    bedId: bedIdCtrl.text.trim(),
                    bedNumber: bedNumCtrl.text.trim(),
                    status: selectedStatus,
                  );
              Navigator.of(ctx2).pop();
            },
            formContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fieldLabel('Bed ID'),
                const SizedBox(height: 6),
                TextField(
                  controller: bedIdCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Enter bed ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                _fieldLabel('Bed Number'),
                const SizedBox(height: 6),
                TextField(
                  controller: bedNumCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.bed_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                _fieldLabel('Status'),
                const SizedBox(height: 6),
                DropdownButtonFormField<int>(
                  initialValue: selectedStatus,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(
                        value: 0, child: Text('Available')),
                    DropdownMenuItem(
                        value: 1, child: Text('Occupied')),
                    DropdownMenuItem(
                        value: 2, child: Text('Maintenance')),
                  ],
                  onChanged: (v) => setS(() => selectedStatus = v ?? 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteBedDialog() async {
    final bedIdCtrl = TextEditingController();
    final confirmed = await showDialog<String?>(
      context: context,
      builder: (ctx) => AdminFormDialog(
        title: 'Delete Bed',
        titleIcon: Icons.delete_outline,
        submitLabel: 'Continue',
        onSubmit: () =>
            Navigator.of(ctx).pop(bedIdCtrl.text.trim()),
        formContent: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Bed ID',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: bedIdCtrl,
              decoration: const InputDecoration(
                hintText: 'Bed ID to delete',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.bed_outlined),
              ),
            ),
          ],
        ),
      ),
    );

    if (confirmed != null && confirmed.isNotEmpty && mounted) {
      final ok = await AdminConfirmDialog.show(
        context: context,
        title: 'Confirm Delete',
        message: 'Are you sure you want to delete bed "$confirmed"?',
        confirmLabel: 'Delete',
        icon: Icons.delete_forever_outlined,
      );
      if (ok && mounted) {
        context.read<AdminBedsCubit>().deleteBed(confirmed);
      }
    }
  }

  Widget _fieldLabel(String text) => Text(text,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 13));
}
