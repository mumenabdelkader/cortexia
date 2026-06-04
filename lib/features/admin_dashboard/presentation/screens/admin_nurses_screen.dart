import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/data/models/nurse_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_nurses_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_form_dialog.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_schedules_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminNursesScreen extends StatefulWidget {
  const AdminNursesScreen({super.key});

  @override
  State<AdminNursesScreen> createState() => _AdminNursesScreenState();
}

class _AdminNursesScreenState extends State<AdminNursesScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<AdminNursesCubit>().getNurses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminNursesCubit, AdminNursesState>(
      listener: (context, state) {
        if (state is AdminNursesSuccess) {
          final msgs = {
            kCreateNurse: 'Nurse created successfully!',
            kUpdateNurse: 'Nurse updated successfully!',
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msgs[state.operation] ?? 'Action completed!'),
              backgroundColor: AppColors.successGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          context.read<AdminNursesCubit>().getNurses();
        } else if (state is AdminNursesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorRed,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                title: 'Nurses',
                subtitle: 'Manage nurses and their departments',
                actionLabel: 'Create Nurse',
                actionIcon: Icons.add,
                onAction: _showCreateNurseDialog,
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search by name or department...',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              if (state is AdminNursesLoading || state is AdminNursesInitial)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(color: AppColors.primaryBlue),
                  ),
                )
              else if (state is AdminNursesLoaded)
                _buildNursesList(state.nurses)
              else if (state is AdminNursesError)
                _buildError(state.message),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNursesList(List<NurseModel> nurses) {
    final filtered = _searchQuery.isEmpty
        ? nurses
        : nurses.where((n) {
            final q = _searchQuery.toLowerCase();
            return (n.name?.toLowerCase().contains(q) ?? false) ||
                (n.department?.toLowerCase().contains(q) ?? false);
          }).toList();

    if (filtered.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('No nurses found.', style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 3
                : constraints.maxWidth > 500
                    ? 2
                    : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: filtered.length,
          itemBuilder: (context, i) => _buildNurseCard(filtered[i]),
        );
      },
    );
  }

  Widget _buildNurseCard(NurseModel nurse) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.infoBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.infoBlue.withValues(alpha: 0.2),
                  child: const Icon(Icons.medical_information, color: AppColors.infoBlue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nurse.displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textMain),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        nurse.department ?? 'General',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_month_outlined, size: 20, color: AppColors.infoBlue),
                      onPressed: () => AdminSchedulesDialog.show(context, nurse.id ?? '', nurse.displayName),
                      tooltip: 'View Schedules',
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.infoBlue),
                      onPressed: () => _showEditNurseDialog(nurse),
                      tooltip: 'Edit Nurse',
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.badge_outlined, nurse.roleLabel),
                  const SizedBox(height: 8),
                  _infoRow(Icons.schedule_outlined, nurse.shiftLabel),
                  const SizedBox(height: 8),
                  _infoRow(Icons.phone_outlined, nurse.phoneNumber ?? 'N/A'),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      nurse.nationalId ?? 'N/A',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.infoBlue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: AppColors.textMain),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showCreateNurseDialog() {
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final fullNameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final nationalIdCtrl = TextEditingController();
    final dobCtrl = TextEditingController(text: "1990-01-01T00:00:00");
    final streetCtrl = TextEditingController();
    final cityCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final zipCtrl = TextEditingController();
    final deptCtrl = TextEditingController();

    int gender = 0;
    int shift = 0;
    int role = 0;

    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminNursesCubit>(),
        child: StatefulBuilder(
          builder: (ctx2, setS) => AdminFormDialog(
            title: 'Create Nurse',
            titleIcon: Icons.add,
            submitLabel: 'Create',
            onSubmit: () {
              ctx2.read<AdminNursesCubit>().createNurse(CreateUserRequest(
                    email: emailCtrl.text.trim(),
                    password: passwordCtrl.text.trim(),
                    role: 'Nurse',
                    fullName: fullNameCtrl.text.trim(),
                    phoneNumber: phoneCtrl.text.trim(),
                    dateOfBirth: dobCtrl.text.trim(),
                    gender: gender,
                    nationalId: nationalIdCtrl.text.trim(),
                    street: streetCtrl.text.trim(),
                    city: cityCtrl.text.trim(),
                    state: stateCtrl.text.trim(),
                    zipCode: zipCtrl.text.trim(),
                    shift: shift,
                    department: deptCtrl.text.trim(),
                    nurseRole: role,
                  ));
              Navigator.of(ctx2).pop();
            },
            formContent: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _formField('Full Name', fullNameCtrl, Icons.person, 'Jane Doe'),
                  const SizedBox(height: 12),
                  _formField('Email', emailCtrl, Icons.email, 'nurse@hospital.com'),
                  const SizedBox(height: 12),
                  _formField('Password', passwordCtrl, Icons.lock, 'min 8 chars', obscure: true),
                  const SizedBox(height: 12),
                  _formField('Phone', phoneCtrl, Icons.phone, '+123456789'),
                  const SizedBox(height: 12),
                  _formField('National ID', nationalIdCtrl, Icons.badge, 'ID Number'),
                  const SizedBox(height: 12),
                  _dropdown('Gender', ['Male', 'Female'], gender, (v) => setS(() => gender = v!)),
                  const SizedBox(height: 12),
                  _formField('Department', deptCtrl, Icons.business, 'ER'),
                  const SizedBox(height: 12),
                  _dropdown('Role', ['Staff', 'Head Nurse'], role, (v) => setS(() => role = v!)),
                  const SizedBox(height: 12),
                  _dropdown('Shift', ['Morning', 'Evening', 'Night'], shift, (v) => setS(() => shift = v!)),
                  const SizedBox(height: 12),
                  const Divider(),
                  const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _formField('Street', streetCtrl, Icons.home, '123 Main St'),
                  const SizedBox(height: 12),
                  _formField('City', cityCtrl, Icons.location_city, 'City'),
                  const SizedBox(height: 12),
                  _formField('State', stateCtrl, Icons.map, 'State'),
                  const SizedBox(height: 12),
                  _formField('Zip Code', zipCtrl, Icons.pin_drop, '12345'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditNurseDialog(NurseModel nurse) {
    final fullNameCtrl = TextEditingController(text: nurse.name);
    final phoneCtrl = TextEditingController(text: nurse.phoneNumber);
    final nationalIdCtrl = TextEditingController(text: nurse.nationalId);
    final dobCtrl = TextEditingController(text: nurse.dateOfBirth ?? "1990-01-01T00:00:00");
    final streetCtrl = TextEditingController(text: nurse.address?.street);
    final cityCtrl = TextEditingController(text: nurse.address?.city);
    final stateCtrl = TextEditingController(text: nurse.address?.state);
    final zipCtrl = TextEditingController(text: nurse.address?.zipCode);
    final deptCtrl = TextEditingController(text: nurse.department);

    int gender = nurse.gender ?? 0;
    int shift = nurse.shift ?? 0;
    int role = nurse.role ?? 0;

    showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AdminNursesCubit>(),
        child: StatefulBuilder(
          builder: (ctx2, setS) => AdminFormDialog(
            title: 'Edit Nurse',
            titleIcon: Icons.edit,
            submitLabel: 'Update',
            onSubmit: () {
              ctx2.read<AdminNursesCubit>().updateNurse(
                    nurse.email ?? '',
                    UpdateNurseRequest(
                      fullName: fullNameCtrl.text.trim(),
                      phoneNumber: phoneCtrl.text.trim(),
                      dateOfBirth: dobCtrl.text.trim(),
                      gender: gender,
                      nationalId: nationalIdCtrl.text.trim(),
                      street: streetCtrl.text.trim(),
                      city: cityCtrl.text.trim(),
                      state: stateCtrl.text.trim(),
                      zipCode: zipCtrl.text.trim(),
                      shift: shift,
                      department: deptCtrl.text.trim(),
                      role: role,
                    ),
                  );
              Navigator.of(ctx2).pop();
            },
            formContent: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _formField('Full Name', fullNameCtrl, Icons.person, 'Jane Doe'),
                  const SizedBox(height: 12),
                  _formField('Phone', phoneCtrl, Icons.phone, '+123456789'),
                  const SizedBox(height: 12),
                  _formField('National ID', nationalIdCtrl, Icons.badge, 'ID Number'),
                  const SizedBox(height: 12),
                  _dropdown('Gender', ['Male', 'Female'], gender, (v) => setS(() => gender = v!)),
                  const SizedBox(height: 12),
                  _formField('Department', deptCtrl, Icons.business, 'ER'),
                  const SizedBox(height: 12),
                  _dropdown('Role', ['Staff', 'Head Nurse'], role, (v) => setS(() => role = v!)),
                  const SizedBox(height: 12),
                  _dropdown('Shift', ['Morning', 'Evening', 'Night'], shift, (v) => setS(() => shift = v!)),
                  const SizedBox(height: 12),
                  const Divider(),
                  const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _formField('Street', streetCtrl, Icons.home, '123 Main St'),
                  const SizedBox(height: 12),
                  _formField('City', cityCtrl, Icons.location_city, 'City'),
                  const SizedBox(height: 12),
                  _formField('State', stateCtrl, Icons.map, 'State'),
                  const SizedBox(height: 12),
                  _formField('Zip Code', zipCtrl, Icons.pin_drop, '12345'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> items, int value, ValueChanged<int?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        DropdownButtonFormField<int>(
          value: value,
          decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          items: items.asMap().entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _formField(String label, TextEditingController ctrl, IconData icon, String hint, {bool obscure = false, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon, size: 18),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
          const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.read<AdminNursesCubit>().getNurses(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
