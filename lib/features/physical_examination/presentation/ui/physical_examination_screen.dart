import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/features/physical_examination/presentation/controllers/physical_examination_opreations_const.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/patient/presentation/widgets/additional_notes_section.dart';
import 'package:cortexia/features/patient/presentation/widgets/neurological_examination_section.dart';
import 'package:cortexia/features/patient/presentation/widgets/system_examination_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/features/physical_examination/presentation/controllers/physical_examination_cubit.dart';
import 'package:cortexia/features/physical_examination/data/models/add_physical_examination_command_model.dart';
import 'package:cortexia/features/physical_examination/data/models/physical_examination_model.dart';

class PhysicalExaminationScreen extends StatefulWidget {
  final String? admissionId;

  const PhysicalExaminationScreen({
    super.key,
    this.admissionId,
  });

  @override
  State<PhysicalExaminationScreen> createState() =>
      _PhysicalExaminationScreenState();
}

class _PhysicalExaminationScreenState
    extends State<PhysicalExaminationScreen> {
  String? _existingId;
  String _doctorId = '';
  bool _isLoading = true;

  // Vitals
  final _tempController = TextEditingController();
  final _bpController = TextEditingController();
  final _hrController = TextEditingController();
  final _rrController = TextEditingController();

  // System
  final _genApperanceController = TextEditingController();
  final _eyeController = TextEditingController();
  final _heartController = TextEditingController();
  final _respController = TextEditingController();
  final _abdomenController = TextEditingController();

  // Neurological & Gen
  final _neuroEyeController = TextEditingController();
  final _neuroSkinController = TextEditingController();
  final _neuroLipsController = TextEditingController();

  // Local/Additional
  final _localController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDoctorId();
    _fetchData();
  }

  Future<void> _loadDoctorId() async {
    final userData = await AppCache.getUserData();
    if (mounted) {
      setState(() {
        _doctorId = userData?.userIdInSystem ?? '';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tempController.dispose();
    _bpController.dispose();
    _hrController.dispose();
    _rrController.dispose();
    _genApperanceController.dispose();
    _eyeController.dispose();
    _heartController.dispose();
    _respController.dispose();
    _abdomenController.dispose();
    _neuroEyeController.dispose();
    _neuroSkinController.dispose();
    _neuroLipsController.dispose();
    _localController.dispose();
    super.dispose();
  }

  void _fetchData() {
    if (widget.admissionId == null || widget.admissionId!.isEmpty) return;
    context
        .read<PhysicalExaminationCubit>()
        .getAdmissionsAdmissionidPhysicalExamination(
      admissionid: widget.admissionId!,
    );
  }

  void _clearForm() {
    setState(() {
      _existingId = null;
      _tempController.clear();
      _bpController.clear();
      _hrController.clear();
      _rrController.clear();
      _genApperanceController.clear();
      _eyeController.clear();
      _heartController.clear();
      _respController.clear();
      _abdomenController.clear();
      _neuroEyeController.clear();
      _neuroSkinController.clear();
      _neuroLipsController.clear();
      _localController.clear();
    });
  }

  void _populateData(List<PhysicalExaminationModel> data) {
    if (data.isNotEmpty) {
      final item = data.last;
      setState(() {
        _existingId = item.id;
        _tempController.text = item.temperature?.toString() ?? '';
        _bpController.text = item.bloodPressure ?? '';
        _hrController.text = item.pulse?.toString() ?? '';
        _rrController.text = item.respRate?.toString() ?? '';
        _genApperanceController.text = '';
        _eyeController.text = '';
        _heartController.text = item.heartExam ?? '';
        _respController.text = '';
        _abdomenController.text = item.abdomenExam ?? '';
        _neuroEyeController.text = item.eyeStatus ?? '';
        _neuroSkinController.text = item.skinStatus ?? '';
        _neuroLipsController.text = item.lipsStatus ?? '';
        _localController.text = item.localExamination ?? '';
      });
    }
  }

  void _save(BuildContext context) {
    final admissionId = widget.admissionId;
    if (admissionId == null || admissionId.isEmpty) return;

    final command = AddPhysicalExaminationCommandModel(
      id: _existingId,
      admissionId: admissionId,
      doctorId: _doctorId,
      examDate: DateTime.now().toIso8601String(),
      temperature: double.tryParse(_tempController.text),
      bloodPressure: _bpController.text,
      pulse: int.tryParse(_hrController.text),
      respRate: int.tryParse(_rrController.text),
      heartExam: _heartController.text,
      abdomenExam: _abdomenController.text,
      eyeStatus: _neuroEyeController.text,
      skinStatus: _neuroSkinController.text,
      lipsStatus: _neuroLipsController.text,
      localExamination: _localController.text,
    );

    if (_existingId != null) {
      context
          .read<PhysicalExaminationCubit>()
          .putAdmissionsAdmissionidPhysicalExamination(
        admissionid: admissionId,
        requestBody: command,
      );
    } else {
      context
          .read<PhysicalExaminationCubit>()
          .postAdmissionsAdmissionidPhysicalExamination(
        admissionid: admissionId,
        requestBody: command,
      );
    }
  }

  void _delete(BuildContext context) {
    final admissionId = widget.admissionId;
    final id = _existingId;
    if (admissionId == null || admissionId.isEmpty || id == null) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Examination'),
        content: const Text(
          'Are you sure you want to delete this physical examination record? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(dialogContext);
              context
                  .read<PhysicalExaminationCubit>()
                  .deleteAdmissionsAdmissionidPhysicalExamination(
                admissionid: admissionId,
                id: id,
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Physical Examination",
        subtitle: widget.admissionId != null
            ? "Admission • ${widget.admissionId}"
            : "Physical Examination",
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : BlocConsumer<PhysicalExaminationCubit, PhysicalExaminationState>(
        listener: (context, state) {
          if (state is PhysicalExaminationStateSuccess) {

            // التعديل: استدعاء _populateData داخل الـ listener لضمان التحديث الآمن للحالة
            if (state.operation == kGetAdmissionsAdmissionidPhysicalExamination) {
              _populateData(state.data as List<PhysicalExaminationModel>? ?? []);
            }

            switch (state.operation) {
              case kPostAdmissionsAdmissionidPhysicalExamination:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Examination created successfully ✅'),
                    backgroundColor: Colors.green,
                  ),
                );
                _fetchData();
                break;
              case kPutAdmissionsAdmissionidPhysicalExamination:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Examination updated successfully ✅'),
                    backgroundColor: Colors.blue,
                  ),
                );
                _fetchData();
                break;
              case kDeleteAdmissionsAdmissionidPhysicalExamination:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Examination deleted successfully 🗑️'),
                    backgroundColor: Colors.orange,
                  ),
                );
                _clearForm();
                break;
            }
          } else if (state is PhysicalExaminationStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PhysicalExaminationStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // التعديل: تم حذف شرط (state.operation == kGetAdmissionsAdmissionidPhysicalExamination)
          // و _populateData(state.data) من هنا لتجنب خطأ الـ setState

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  children: [
                    // ── Record banner (shown when record exists) ───────
                    if (_existingId != null)
                      _buildRecordBanner(context),
                    if (_existingId != null)
                      const SizedBox(height: 16),
                    _buildVitalSignsInputs(),
                    const SizedBox(height: 24),
                    SystemExaminationSection(
                      generalApperanceController: _genApperanceController,
                      eyeController: _eyeController,
                      heartController: _heartController,
                      respController: _respController,
                      abdomenController: _abdomenController,
                    ),
                    const SizedBox(height: 16),
                    NeurologicalExaminationSection(
                      eyeController: _neuroEyeController,
                      skinController: _neuroSkinController,
                      lipsController: _neuroLipsController,
                    ),
                    const SizedBox(height: 16),
                    AdditionalNotesSection(controller: _localController),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              _buildBottomActions(context),
            ],
          );
        },
      ),
    );
  }

  /// Banner shown when a record already exists — shows record ID.
  Widget _buildRecordBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.assignment_turned_in_outlined,
              color: Colors.indigo.shade400, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Existing record: $_existingId',
              style: TextStyle(
                color: Colors.indigo.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignsInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current Vitals Snapshot",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _tempController,
                labelText: "Temp (°C)",
                hintText: "37.0",
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextFormField(
                controller: _bpController,
                labelText: "BP (mmHg)",
                hintText: "120/80",
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _hrController,
                labelText: "Heart Rate (bpm)",
                hintText: "80",
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextFormField(
                controller: _rrController,
                labelText: "Resp Rate (br/min)",
                hintText: "16",
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Bottom bar: Save/Update + optional Delete button.
  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Delete button (only when a record exists) ─────────────────────
          if (_existingId != null) ...[
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => _delete(context),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // ── Save / Update button ────────────────────────────────────────
          Expanded(
            child: CustomElevatedButton(
              text: _existingId != null
                  ? 'Update Examination'
                  : 'Save Examination',
              borderRadius: 12.0,
              onPressed: () => _save(context),
            ),
          ),
        ],
      ),
    );
  }
}