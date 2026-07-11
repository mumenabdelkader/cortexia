import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/admission/data/models/admit_patient_command.dart';
import 'package:cortexia/features/admission/data/models/room_model.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
import 'package:cortexia/features/patient/presentation/ui/patient_list_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/form_section_container.dart';
import 'package:cortexia/features/patients/data/models/blood_type.dart';
import 'package:cortexia/features/patients/data/models/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class NewPatientRegistrationScreen extends StatefulWidget {
  const NewPatientRegistrationScreen({super.key});

  @override
  State<NewPatientRegistrationScreen> createState() =>
      _NewPatientRegistrationScreenState();
}

class _NewPatientRegistrationScreenState
    extends State<NewPatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // ── Cubit (created here so _submit can call it directly) ──────────────────
  late final AdmissionCubit _cubit;

  // ── Personal info controllers ─────────────────────────────────────────────
  final _nameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _diagnosisSummaryController = TextEditingController();

  // ── Address controllers ────────────────────────────────────────────────────
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();

  // ── Admission controllers ──────────────────────────────────────────────────
  final _initialDiagnosisController = TextEditingController();

  // ── Dropdown selections ────────────────────────────────────────────────────
  Gender? _selectedGender;
  BloodType? _selectedBloodType;
  RoomModel? _selectedRoom;
  BedModel? _selectedBed;

  static const _genderLabels = {
    Gender.value0: 'Male',
    Gender.value1: 'Female',
  };

  @override
  void initState() {
    super.initState();
    _cubit = AdmissionCubit(GetIt.I.get())..loadRooms();
  }

  @override
  void dispose() {
    for (final c in [
      _nameController,
      _nationalIdController,
      _dateOfBirthController,
      _emailController,
      _phoneController,
      _diagnosisSummaryController,
      _streetController,
      _cityController,
      _stateController,
      _zipCodeController,
      _countryController,
      _initialDiagnosisController,
    ]) {
      c.dispose();
    }
    _cubit.close();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            '${picked.toUtc().toIso8601String().split('.').first}Z';
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBed == null || _selectedRoom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a room and bed.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final userData = await AppCache.getUserData();
    final doctorId = userData?.userIdInSystem ?? '';

    if (!mounted) return;
    _cubit.admitPatient(
          AdmitPatientCommand(
            name: _nameController.text.trim(),
            nationalId: _nationalIdController.text.trim(),
            dateOfBirth: _dateOfBirthController.text.trim(),
            gender: _selectedGender,
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            street: _streetController.text.trim(),
            city: _cityController.text.trim(),
            state: _stateController.text.trim(),
            zipCode: _zipCodeController.text.trim(),
            country: _countryController.text.trim(),
            bloodType: _selectedBloodType,
            diagnosisSummary: _diagnosisSummaryController.text.trim(),
            doctorId: doctorId,
            initialDiagnosis: _initialDiagnosisController.text.trim(),
            roomId: _selectedRoom!.roomId,
            bedId: _selectedBed!.bedId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<AdmissionCubit, AdmissionState>(
        listener: (context, state) {
          if (state is AdmitPatientSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Patient admitted successfully! ✅'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const PatientListScreen()),
            );
          } else if (state is AdmissionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final rooms = state is RoomsLoaded ? state.rooms : <RoomModel>[];
          final isSubmitting = state is AdmissionLoading;
          final isLoadingRooms = state is RoomsLoading;

          return Scaffold(
            appBar: const CustomAppBar(
              title: 'Admit New Patient',
              subtitle: 'Complete patient & admission info',
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // ── Personal Information ─────────────────────────────────
                    FormSectionContainer(
                      title: 'Personal Information',
                      icon: Icons.person_add_alt_1_outlined,
                      children: [
                        CustomTextFormField(
                          labelText: 'Full Name *',
                          hintText: 'Enter patient\'s full name',
                          controller: _nameController,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'National ID *',
                                hintText: 'Enter National ID',
                                controller: _nationalIdController,
                                keyboardType: TextInputType.number,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Required'
                                        : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: _selectDate,
                                child: AbsorbPointer(
                                  child: CustomTextFormField(
                                    labelText: 'Date of Birth *',
                                    hintText: 'Select date',
                                    controller: _dateOfBirthController,
                                    suffixIcon: const Icon(
                                        Icons.calendar_month_outlined),
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                            ? 'Required'
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'Email',
                                hintText: 'patient@email.com',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'Phone',
                                hintText: '+20xxxxxxxxxx',
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown<Gender>(
                                label: 'Gender *',
                                value: _selectedGender,
                                items: Gender.values,
                                labelOf: (g) => _genderLabels[g]!,
                                onChanged: (g) =>
                                    setState(() => _selectedGender = g),
                                validator: (v) =>
                                    v == null ? 'Required' : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDropdown<BloodType>(
                                label: 'Blood Type',
                                value: _selectedBloodType,
                                items: BloodType.values,
                                labelOf: (b) => b.displayLabel,
                                onChanged: (b) =>
                                    setState(() => _selectedBloodType = b),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          labelText: 'Diagnosis Summary',
                          hintText: 'Brief summary of condition',
                          controller: _diagnosisSummaryController,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Address ──────────────────────────────────────────────
                    FormSectionContainer(
                      title: 'Address Information',
                      icon: Icons.location_on_outlined,
                      iconColor: AppColors.primaryBlue,
                      children: [
                        CustomTextFormField(
                          labelText: 'Street *',
                          hintText: 'Enter street address',
                          controller: _streetController,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'City *',
                                hintText: 'e.g. Cairo',
                                controller: _cityController,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Required'
                                        : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'State *',
                                hintText: 'e.g. Giza',
                                controller: _stateController,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Required'
                                        : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'Country *',
                                hintText: 'e.g. Egypt',
                                controller: _countryController,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Required'
                                        : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTextFormField(
                                labelText: 'Zip Code',
                                hintText: 'Enter zip code',
                                controller: _zipCodeController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Admission Details ────────────────────────────────────
                    FormSectionContainer(
                      title: 'Admission Details',
                      icon: Icons.login_outlined,
                      iconColor: Colors.teal,
                      children: [
                        CustomTextFormField(
                          labelText: 'Initial Diagnosis *',
                          hintText: 'Enter initial diagnosis',
                          prefixIcon: Icons.medical_services_outlined,
                          controller: _initialDiagnosisController,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                        const SizedBox(height: 16),

                        // ── Room selector ──────────────────────────────────
                        if (isLoadingRooms)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else ...[
                          _buildDropdown<RoomModel>(
                            label: 'Room *',
                            value: _selectedRoom,
                            items: rooms,
                            labelOf: (r) =>
                                '${r.roomNumber} · ${r.roomTypeLabel} · Floor ${r.floor}',
                            onChanged: (r) => setState(() {
                              _selectedRoom = r;
                              _selectedBed = null;
                            }),
                          ),
                          const SizedBox(height: 16),

                          // ── Bed selector (filtered to available) ──────────
                          _buildDropdown<BedModel>(
                            label: 'Bed *',
                            value: _selectedBed,
                            items: _selectedRoom?.availableBeds ?? [],
                            labelOf: (b) =>
                                '${b.bedNumber} · ${b.isAvailable ? "Available" : "Occupied"}',
                            onChanged: _selectedRoom == null
                                ? null
                                : (b) => setState(() => _selectedBed = b),
                          ),
                          if (_selectedRoom != null &&
                              (_selectedRoom!.availableBeds.isEmpty))
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.warning_amber_outlined,
                                      size: 14,
                                      color: Colors.orange.shade700),
                                  const SizedBox(width: 4),
                                  Text(
                                    'No available beds in this room.',
                                    style: TextStyle(
                                        color: Colors.orange.shade700,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                        ],

                        const SizedBox(height: 24),

                        isSubmitting
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.teal),
                              )
                            : CustomElevatedButton(
                                text: 'Admit Patient',
                                onPressed: _submit,
                              ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) labelOf,
    required ValueChanged<T?>? onChanged,
    String? Function(T?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          hint: Text(
            'Select',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textLight),
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    labelOf(e),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEDF2F7),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
