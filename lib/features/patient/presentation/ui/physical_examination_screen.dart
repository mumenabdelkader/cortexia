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

class PhysicalExaminationScreen extends StatefulWidget {
  final String admissionId;
  final String doctorId;

  const PhysicalExaminationScreen({
    super.key,
    this.admissionId = 'ADM-7A21F7EF3C7D',
    this.doctorId = 'DOC-1436C0633BBD',
  });

  @override
  State<PhysicalExaminationScreen> createState() => _PhysicalExaminationScreenState();
}

class _PhysicalExaminationScreenState extends State<PhysicalExaminationScreen> {
  String? _existingId;
  
  // Vitals
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _bpController = TextEditingController();
  final TextEditingController _hrController = TextEditingController();
  final TextEditingController _rrController = TextEditingController();

  // System
  final TextEditingController _genApperanceController = TextEditingController();
  final TextEditingController _eyeController = TextEditingController();
  final TextEditingController _heartController = TextEditingController();
  final TextEditingController _respController = TextEditingController();
  final TextEditingController _abdomenController = TextEditingController();

  // Neurological & Gen
  final TextEditingController _neuroEyeController = TextEditingController();
  final TextEditingController _neuroSkinController = TextEditingController();
  final TextEditingController _neuroLipsController = TextEditingController();

  // Local/Additional
  final TextEditingController _localController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<PhysicalExaminationCubit>().getAdmissionsAdmissionidPhysicalExamination(
          admissionid: widget.admissionId,
        );
  }

  void _populateData(dynamic data) {
    if (data is Map<String, dynamic> || data is List<dynamic> && data.isNotEmpty) {
      final item = (data is List<dynamic>) ? data.last : data; // Get the latest examination
      
      _existingId = item['id'];
      _tempController.text = item['temperature']?.toString() ?? '';
      _bpController.text = item['bloodPressure'] ?? '';
      _hrController.text = item['pulse']?.toString() ?? '';
      _rrController.text = item['respRate']?.toString() ?? '';

      _genApperanceController.text = ''; // API has no general appearance directly mapped.
      _eyeController.text = ''; // Reusing _neuroEyeController for eyeStatus.
      _heartController.text = item['heartExam'] ?? '';
      _respController.text = ''; // API has no separate respiratory model other than rr.
      _abdomenController.text = item['abdomenExam'] ?? '';

      _neuroEyeController.text = item['eyeStatus'] ?? '';
      _neuroSkinController.text = item['skinStatus'] ?? '';
      _neuroLipsController.text = item['lipsStatus'] ?? '';

      _localController.text = item['localExamination'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Physical Examination",
        subtitle: "Admission • ${widget.admissionId}",
      ),
      body: BlocConsumer<PhysicalExaminationCubit, PhysicalExaminationState>(
        listener: (context, state) {
          if (state is PhysicalExaminationStateSuccess && state.operation != 'get') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Examination Saved Successfully')),
            );
            _fetchData();
          } else if (state is PhysicalExaminationStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is PhysicalExaminationStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PhysicalExaminationStateSuccess && state.operation == 'get') {
            _populateData(state.data);
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: [
                    _buildVitalSignsInputs(),
                    const SizedBox(height: 24),
                    SystemExaminationSection(
                      generalApperanceController: _genApperanceController,
                      eyeController: _eyeController, // Optional second eye box
                      heartController: _heartController,
                      respController: _respController,
                      abdomenController: _abdomenController,
                    ),
                    const SizedBox(height: 16),
                    NeurologicalExaminationSection(
                      eyeController: _neuroEyeController, // Maps to EyeStatus mapped in API
                      skinController: _neuroSkinController, // Maps to SkinStatus mapped in API
                      lipsController: _neuroLipsController, // Maps to LipsStatus mapped in API
                    ),
                    const SizedBox(height: 16),
                    AdditionalNotesSection(
                      controller: _localController, // Maps to LocalExamination mapped in API
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Bottom Action Area
              _buildBottomAction(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVitalSignsInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current Vitals Snapshot",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: CustomTextFormField(controller: _tempController, labelText: "Temp (°C)", hintText: "37.0", keyboardType: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: CustomTextFormField(controller: _bpController, labelText: "BP (mmHg)", hintText: "120/80")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: CustomTextFormField(controller: _hrController, labelText: "Heart Rate (bpm)", hintText: "80", keyboardType: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: CustomTextFormField(controller: _rrController, labelText: "Resp Rate (br/min)", hintText: "16", keyboardType: TextInputType.number)),
          ],
        )
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: CustomElevatedButton(
        text: _existingId != null ? "Update Examination" : "Save Examination",
        borderRadius: 12.0,
        onPressed: () {
          final command = AddPhysicalExaminationCommandModel(
            id: _existingId,
            admissionId: widget.admissionId,
            doctorId: widget.doctorId,
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
            context.read<PhysicalExaminationCubit>().putAdmissionsAdmissionidPhysicalExamination(
              admissionid: widget.admissionId,
              requestBody: command,
            );
          } else {
            context.read<PhysicalExaminationCubit>().postAdmissionsAdmissionidPhysicalExamination(
              admissionid: widget.admissionId,
              requestBody: command,
            );
          }
        },
      ),
    );
  }
}