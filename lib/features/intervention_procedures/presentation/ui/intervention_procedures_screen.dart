import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/features/intervention_procedures/presentation/controllers/intervention_procedures_cubit.dart';
import 'package:cortexia/features/intervention_procedures/data/models/add_intervention_procedure_command_model.dart';
import 'package:cortexia/features/intervention_procedures/data/models/care_intervention_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InterventionProceduresScreen extends StatefulWidget {
  final String admissionId;
  final String nurseId;

  const InterventionProceduresScreen({
    super.key,
    this.admissionId = 'ADM-7A21F7EF3C7D',
    this.nurseId = 'NURSE-001',
  });

  @override
  State<InterventionProceduresScreen> createState() => _InterventionProceduresScreenState();
}

class _InterventionProceduresScreenState extends State<InterventionProceduresScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<InterventionProceduresCubit>().getAdmissionsAdmissionidInterventionProcedures(admissionid: widget.admissionId);
  }

  void _showAddOrEditDialog(BuildContext ctx, {dynamic existingRecord}) {
    final isEdit = existingRecord != null;
    final sizeCtrl = TextEditingController(text: isEdit ? existingRecord['size']?.toString() : '');
    
    DateTime? selectedInsertionDate = isEdit && existingRecord['insertionDate'] != null ? DateTime.tryParse(existingRecord['insertionDate']) : null;
    DateTime? selectedRemovalDate = isEdit && existingRecord['removalDate'] != null ? DateTime.tryParse(existingRecord['removalDate']) : null;

    int initialTypeIndex = 0;
    if (isEdit && existingRecord['type'] != null) {
      if (existingRecord['type'] is int) {
        initialTypeIndex = existingRecord['type'];
      }
    }
    int selectedTypeIndex = initialTypeIndex;

    showDialog(
      context: ctx,
      builder: (dialogCtx) => BlocProvider.value(
        value: context.read<InterventionProceduresCubit>(),
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(isEdit ? "Edit Procedure" : "Log Procedure"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<int>(
                    value: selectedTypeIndex,
                    decoration: const InputDecoration(labelText: 'Procedure Type'),
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('IV Cannula')),
                      DropdownMenuItem(value: 1, child: Text('Urinary Catheter')),
                      DropdownMenuItem(value: 2, child: Text('NG Tube')),
                      DropdownMenuItem(value: 3, child: Text('Central Line')),
                      DropdownMenuItem(value: 4, child: Text('Wound Drain')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedTypeIndex = val);
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    controller: sizeCtrl,
                    labelText: "Size / Context Label",
                    hintText: "14",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text(selectedInsertionDate == null ? "Select Insertion Date" : "Inserted: ${DateFormat('yyyy-MM-dd').format(selectedInsertionDate!)}"),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030));
                      if (picked != null) setState(() => selectedInsertionDate = picked);
                    },
                  ),
                  ListTile(
                    title: Text(selectedRemovalDate == null ? "Select Removal Date" : "Removed: ${DateFormat('yyyy-MM-dd').format(selectedRemovalDate!)}"),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030));
                      if (picked != null) setState(() => selectedRemovalDate = picked);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text("Cancel")),
              CustomElevatedButton(
                text: isEdit ? "Update" : "Save",
                width: 100,
                onPressed: () {
                  final command = AddInterventionProcedureCommandModel(
                    id: isEdit ? existingRecord['id'] : null,
                    admissionId: widget.admissionId,
                    nurseId: widget.nurseId,
                    size: int.tryParse(sizeCtrl.text),
                    insertionDate: selectedInsertionDate?.toIso8601String(),
                    removalDate: selectedRemovalDate?.toIso8601String(),
                    type: CareInterventionType.values.firstWhere(
                      (e) => e.index == selectedTypeIndex,
                      orElse: () => CareInterventionType.ivCannula,
                    ),
                  );

                  if (isEdit) {
                    context.read<InterventionProceduresCubit>().putAdmissionsAdmissionidInterventionProcedures(
                          admissionid: widget.admissionId,
                          requestBody: command,
                        );
                  } else {
                    context.read<InterventionProceduresCubit>().postAdmissionsAdmissionidInterventionProcedures(
                          admissionid: widget.admissionId,
                          requestBody: command,
                        );
                  }
                  Navigator.pop(dialogCtx);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, dynamic entry) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        title: const Text("Delete Record"),
        content: const Text("Are you sure you want to delete this intervention?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              context.read<InterventionProceduresCubit>().deleteAdmissionsAdmissionidInterventionProcedures(
                    admissionid: widget.admissionId,
                    id: entry['id'] as String? ?? '',
                  );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: CustomAppBar(
        title: "Intervention Procedures",
        subtitle: "Admission: ${widget.admissionId}",
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => _showAddOrEditDialog(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Log Procedure", style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<InterventionProceduresCubit, InterventionProceduresState>(
        listener: (context, state) {
          if (state is InterventionProceduresStateSuccess && state.operation != 'get') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Operation ${state.operation} successful')),
            );
            _fetchData();
          } else if (state is InterventionProceduresStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is InterventionProceduresStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is InterventionProceduresStateSuccess && state.operation == 'get') {
            final List<dynamic> data = state.data as List<dynamic>? ?? [];
            if (data.isEmpty) {
              return const Center(child: Text("No Procedures logged.", style: TextStyle(fontSize: 18, color: Colors.grey)));
            }

            return ListView.builder(
              padding: AppDimens.paddingAll16,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final insertionStr = item['insertionDate'] != null ? DateFormat('MMM d, y, hh:mm a').format(DateTime.parse(item['insertionDate']).toLocal()) : 'Unknown Date';
                final removalStr = item['removalDate'] != null ? DateFormat('MMM d, y, hh:mm a').format(DateTime.parse(item['removalDate']).toLocal()) : 'Active';
                final typeName = ['IV Cannula', 'Urinary Catheter', 'NG Tube', 'Central Line', 'Wound Drain'][item['type'] ?? 0];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: AppDimens.paddingAll16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(typeName, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.infoBlue, fontSize: 18)),
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () => _showAddOrEditDialog(context, existingRecord: item)),
                                IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => _confirmDelete(context, item)),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Icon(Icons.open_with, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text("Size: ${item['size'] ?? 'N/A'}", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8),
                         Row(
                          children: [
                            const Icon(Icons.exit_to_app, size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Text("Inserted: $insertionStr", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8),
                         Row(
                          children: [
                            const Icon(Icons.highlight_remove, size: 16, color: Colors.red),
                            const SizedBox(width: 8),
                            Text("Removed: $removalStr", style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          
          return const Center(child: Text("Waiting for data..."));
        },
      ),
    );
  }
}
