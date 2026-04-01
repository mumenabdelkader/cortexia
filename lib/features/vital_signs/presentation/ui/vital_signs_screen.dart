import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/features/vital_signs/presentation/controllers/vital_signs_cubit.dart';
import 'package:cortexia/features/vital_signs/data/models/record_vitals_command_model.dart';
import 'package:cortexia/features/vital_signs/data/models/consciousness_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VitalSignsScreen extends StatefulWidget {
  final String admissionId;
  final String nurseId;

  const VitalSignsScreen({
    super.key,
    this.admissionId = 'ADM-7A21F7EF3C7D',
    this.nurseId = 'NURSE-001',
  });

  @override
  State<VitalSignsScreen> createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<VitalSignsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<VitalSignsCubit>().getAdmissionsAdmissionidVitals(admissionid: widget.admissionId);
  }

  void _showAddOrEditDialog(BuildContext ctx, {dynamic existingRecord}) {
    final isEdit = existingRecord != null;
    final tempCtrl = TextEditingController(text: isEdit ? existingRecord['temperature']?.toString() : '');
    final sysCtrl = TextEditingController(text: isEdit ? existingRecord['bP_Systolic']?.toString() : '');
    final diaCtrl = TextEditingController(text: isEdit ? existingRecord['bP_Diastolic']?.toString() : '');
    final heartCtrl = TextEditingController(text: isEdit ? existingRecord['heartRate']?.toString() : '');
    final respCtrl = TextEditingController(text: isEdit ? existingRecord['respRate']?.toString() : '');
    final oxyCtrl = TextEditingController(text: isEdit ? existingRecord['pulseOxy']?.toString() : '');
    
    bool hasSupplOxygen = isEdit ? (existingRecord['supplementalOxygen'] == true) : false;
    
    // Determine initial enum
    int initialConsciousnessIndex = 0; // Default to Alert
    if (isEdit && existingRecord['consciousnessLevel'] != null) {
      if (existingRecord['consciousnessLevel'] is int) {
        initialConsciousnessIndex = existingRecord['consciousnessLevel'];
      } else if (existingRecord['consciousnessLevel'] == 'Alert') {
        initialConsciousnessIndex = 0;
      } else if (existingRecord['consciousnessLevel'] == 'Voice') {
        initialConsciousnessIndex = 1;
      } else if (existingRecord['consciousnessLevel'] == 'Pain') {
        initialConsciousnessIndex = 2;
      } else if (existingRecord['consciousnessLevel'] == 'Unresponsive') {
        initialConsciousnessIndex = 3;
      }
    }
    int selectedConscIndex = initialConsciousnessIndex;

    showDialog(
      context: ctx,
      builder: (dialogCtx) => BlocProvider.value(
        value: context.read<VitalSignsCubit>(),
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(isEdit ? "Edit Vitals Record" : "Add Vitals Record"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(child: CustomTextFormField(controller: tempCtrl, labelText: "Temp (°C)", hintText: "37.5", keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: CustomTextFormField(controller: heartCtrl, labelText: "HR (bpm)", hintText: "80", keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: CustomTextFormField(controller: sysCtrl, labelText: "Sys/BP", hintText: "120", keyboardType: TextInputType.number)),
                      const Text(" / ", style: TextStyle(fontSize: 18)),
                      Expanded(child: CustomTextFormField(controller: diaCtrl, labelText: "Dia/BP", hintText: "80", keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: CustomTextFormField(controller: respCtrl, labelText: "Resp Rate", hintText: "16", keyboardType: TextInputType.number)),
                      const SizedBox(width: 8),
                      Expanded(child: CustomTextFormField(controller: oxyCtrl, labelText: "PulseOx %", hintText: "98", keyboardType: TextInputType.number)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text("Supplemental Oxygen?"),
                    value: hasSupplOxygen,
                    onChanged: (val) => setState(() => hasSupplOxygen = val),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    value: selectedConscIndex,
                    decoration: const InputDecoration(labelText: 'Consciousness Level'),
                    items: const [
                      DropdownMenuItem(value: 0, child: Text('Alert')),
                      DropdownMenuItem(value: 1, child: Text('Voice')),
                      DropdownMenuItem(value: 2, child: Text('Pain')),
                      DropdownMenuItem(value: 3, child: Text('Unresponsive')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedConscIndex = val);
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
                  final command = RecordVitalsCommandModel(
                    id: isEdit ? existingRecord['id'] : null,
                    admissionId: widget.admissionId,
                    nurseId: widget.nurseId,
                    temperature: double.tryParse(tempCtrl.text),
                    bP_Systolic: int.tryParse(sysCtrl.text),
                    bP_Diastolic: int.tryParse(diaCtrl.text),
                    heartRate: int.tryParse(heartCtrl.text),
                    respRate: int.tryParse(respCtrl.text),
                    pulseOxy: int.tryParse(oxyCtrl.text),
                    supplementalOxygen: hasSupplOxygen,
                    recordedAt: isEdit ? existingRecord['recordedAt'] : DateTime.now().toIso8601String(),
                    consciousnessLevel: ConsciousnessLevel.values.firstWhere(
                      (e) => e.index == selectedConscIndex,
                      orElse: () => ConsciousnessLevel.alert,
                    ),
                  );

                  if (isEdit) {
                    context.read<VitalSignsCubit>().putAdmissionsAdmissionidVitals(
                          admissionid: widget.admissionId,
                          requestBody: command,
                        );
                  } else {
                    context.read<VitalSignsCubit>().postAdmissionsAdmissionidVitals(
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
        content: const Text("Are you sure you want to delete this vital signs record?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              context.read<VitalSignsCubit>().deleteAdmissionsAdmissionidVitals(
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
        title: "Vital Signs",
        subtitle: "Admission: ${widget.admissionId}",
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () => _showAddOrEditDialog(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Record Vitals", style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<VitalSignsCubit, VitalSignsState>(
        listener: (context, state) {
          if (state is VitalSignsStateSuccess && state.operation != 'get') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Operation ${state.operation} successful')),
            );
            _fetchData();
          } else if (state is VitalSignsStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is VitalSignsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is VitalSignsStateSuccess && state.operation == 'get') {
            final List<dynamic> data = state.data as List<dynamic>? ?? [];
            if (data.isEmpty) {
              return const Center(child: Text("No Vital Signs Recorded", style: TextStyle(fontSize: 18, color: Colors.grey)));
            }

            return ListView.builder(
              padding: AppDimens.paddingAll16,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final dateStr = item['recordedAt'] != null ? DateFormat('MMM d, y, hh:mm a').format(DateTime.parse(item['recordedAt']).toLocal()) : 'Unknown Time';

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
                            Text(dateStr, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textMain)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoCol("Temp", "${item['temperature']}°C", Icons.thermostat),
                            _buildInfoCol("BP", "${item['bP_Systolic']}/${item['bP_Diastolic']}", Icons.favorite_border),
                            _buildInfoCol("HR", "${item['heartRate']}", Icons.favorite),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoCol("Resp", "${item['respRate']}/m", Icons.air),
                            _buildInfoCol("SpO2", "${item['pulseOxy']}%", Icons.bloodtype),
                            _buildInfoCol("O2 Suppl", (item['supplementalOxygen'] == true) ? "Yes" : "No", Icons.vaccines),
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

  Widget _buildInfoCol(String label, String val, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryBlue),
        const SizedBox(height: 4),
        Text(val.replaceAll('null', '-'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
