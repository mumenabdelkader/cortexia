import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_cubit.dart';
import 'package:cortexia/features/admission/presentation/controllers/admission_state.dart';
import 'package:cortexia/features/admission/presentation/widgets/admission_form_section_container.dart';
import 'package:cortexia/features/patient/presentation/ui/patient_list_screen.dart';
import 'package:cortexia/features/patient/presentation/widgets/form_section_container.dart';
import 'package:cortexia/features/patient/presentation/widgets/patient_id_header.dart';
import 'package:cortexia/features/patients/data/models/blood_type.dart';
import 'package:cortexia/features/patients/data/models/create_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/gender.dart';

import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/features/patients/presentation/controllers/patients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/color_themes.dart';
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
  // ── Form key ──────────────────────────────────────────────────────────────
  final _formKey = GlobalKey<FormState>();

  // ── Personal Information controllers ─────────────────────────────────────
  final _nameController        = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController       = TextEditingController();
  final _phoneController       = TextEditingController();
  final _nationalIdController  = TextEditingController();
  final _fileNumberController  = TextEditingController();
  
  // controllers العنوان
  final _streetController      = TextEditingController();
  final _cityController        = TextEditingController();
  final _stateController       = TextEditingController();
  final _countryController     = TextEditingController();
  final _zipCodeController     = TextEditingController();

  Gender?   _selectedGender;
  BloodType? _selectedBloodType;
  String? _registeredPatientId;

  @override
  void dispose() {
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _fileNumberController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  // ── Gender labels ─────────────────────────────────────────────────────────
  static const _genderLabels = {
    Gender.value0: 'Male',
    Gender.value1: 'Female',
  };

  // ── BloodType labels ──────────────────────────────────────────────────────
  static const _bloodTypeLabels = {
    BloodType.value0: 'A+',
    BloodType.value1: 'A−',
    BloodType.value2: 'B+',
    BloodType.value3: 'B−',
    BloodType.value4: 'AB+',
    BloodType.value5: 'AB−',
    BloodType.value6: 'O+',
    BloodType.value7: 'O−',
    BloodType.value8: 'Unknown',
  };

  // ── Date Picker ──────────────────────────────────────────────────────────
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        // الـ API محتاج الـ Format ده: 1992-07-15T00:00:00Z
        _dateOfBirthController.text = '${picked.toUtc().toIso8601String().split('.').first}Z';
      });
    }
  }

  // ── Submit ────────────────────────────────────────────────────────────────
  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final requestBody = CreatePatientCommandModel(
      name:        _nameController.text.trim(),
      dateOfBirth: _dateOfBirthController.text.trim(),
      email:       _emailController.text.trim(),
      phoneNumber:  _phoneController.text.trim(),
      gender:      _selectedGender,
      bloodType:   _selectedBloodType,
      fileNumber:  _fileNumberController.text.trim(),
      nationalId:  _nationalIdController.text.trim(),
      street:      _streetController.text.trim(),
      city:        _cityController.text.trim(),
      state:       _stateController.text.trim(),
      country:     _countryController.text.trim(),
      zipCode:     _zipCodeController.text.trim(),
    );

    context.read<PatientsCubit>().postPatients(requestBody: requestBody);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PatientsCubit(GetIt.I.get())),
        BlocProvider(create: (_) => AdmissionCubit(GetIt.I.get())),
      ],
      child: Builder(
        builder: (context) => Scaffold(
      appBar: const CustomAppBar(
        title: "New Patient Registration",
        subtitle: "Complete patient information",
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AdmissionCubit, AdmissionState>(
                listener: (context, state) {
                  if (state is AdmissionSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => PatientListScreen()),
                    );
                  }
                },
              ),
            ],
            child: BlocConsumer<PatientsCubit, PatientsState>(
            listener: (context, state) {
              if (state is PatientsStateSuccess &&
                  state.operation == 'postPatients') {
                setState(() {
                  _registeredPatientId = state.data['id'];
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Patient info saved! Now please complete admission details."),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is PatientsStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is PatientsStateLoading;

              return Column(
                children: [
                  // ── Patient ID Header ────────────────────────────────────
                  PatientIdHeader(
                    patientId: _registeredPatientId ?? '---',
                  ),

                  const SizedBox(height: 20),

                  // ── Personal Information ─────────────────────────────────
                  AbsorbPointer(
                    absorbing: _registeredPatientId != null,
                    child: Opacity(
                      opacity: _registeredPatientId != null ? 0.7 : 1.0,
                      child: FormSectionContainer(
                        title: "Personal Information",
                        icon: Icons.person_add_alt_1_outlined,
                        children: [
                          CustomTextFormField(
                            labelText: "Full Name *",
                            hintText: "Enter patient's full name",
                            controller: _nameController,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: _registeredPatientId != null ? null : () => _selectDate(context),
                            child: AbsorbPointer(
                              child: CustomTextFormField(
                                labelText: "Date of Birth *",
                                hintText: "Select birth date",
                                controller: _dateOfBirthController,
                                suffixIcon: const Icon(Icons.calendar_month_outlined),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty) ? 'Required' : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "National ID *",
                                  hintText: "Enter National ID",
                                  controller: _nationalIdController,
                                  keyboardType: TextInputType.number,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "File Number *",
                                  hintText: "FN-2026-XXXXX",
                                  controller: _fileNumberController,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "Email",
                                  hintText: "patient@email.com",
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "Phone",
                                  hintText: "+20xxxxxxxxxx",
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
                                  label: "Gender *",
                                  hint: "Select",
                                  value: _selectedGender,
                                  items: Gender.values,
                                  labelOf: (g) => _genderLabels[g]!,
                                  onChanged: _registeredPatientId != null ? null : (g) =>
                                      setState(() => _selectedGender = g),
                                  validator: (v) =>
                                      v == null ? 'Required' : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDropdown<BloodType>(
                                  label: "Blood Type",
                                  hint: "Select",
                                  value: _selectedBloodType,
                                  items: BloodType.values,
                                  labelOf: (b) => _bloodTypeLabels[b]!,
                                  onChanged: _registeredPatientId != null ? null : (b) =>
                                      setState(() => _selectedBloodType = b),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Address Information ──────────────────────────────────
                  AbsorbPointer(
                    absorbing: _registeredPatientId != null,
                    child: Opacity(
                      opacity: _registeredPatientId != null ? 0.7 : 1.0,
                      child: FormSectionContainer(
                        title: "Address Information",
                        icon: Icons.location_on_outlined,
                        iconColor: AppColors.primaryBlue,
                        children: [
                          CustomTextFormField(
                            labelText: "Street *",
                            hintText: "Enter street address",
                            controller: _streetController,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "City *",
                                  hintText: "e.g. Giza",
                                  controller: _cityController,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "State *",
                                  hintText: "e.g. Giza",
                                  controller: _stateController,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "Country *",
                                  hintText: "e.g. Egypt",
                                  controller: _countryController,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: "Zip Code *",
                                  hintText: "Enter Zip Code",
                                  controller: _zipCodeController,
                                  keyboardType: TextInputType.number,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          if (_registeredPatientId == null)
                            isLoading
                                ? const CircularProgressIndicator()
                                : CustomElevatedButton(
                            text: "Save Patient Info",
                            onPressed: () => _submit(context),
                          ),
                          if (_registeredPatientId != null)
                             const Padding(
                               padding: EdgeInsets.symmetric(vertical: 8.0),
                               child: Text("Personal Info Saved ✅", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                             ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Admission Details ────────────────────────────────────
                  AbsorbPointer(
                    absorbing: _registeredPatientId == null,
                    child: Opacity(
                      opacity: _registeredPatientId == null ? 0.5 : 1.0,
                      child: AdmissionFormSectionContainer(
                        patientId: _registeredPatientId,
                        doctorId: "DOC-1436C0633BBD",
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    ))));
  }

  // ── Helper: generic dropdown builder ─────────────────────────────────────
  Widget _buildDropdown<T>({
    required String label,
    required String hint,
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
          initialValue: value,
          hint: Text(hint,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textLight)),
          items: items
              .map((e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text(labelOf(e)),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: validator,
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
