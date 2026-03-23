import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_command_model.dart';
import 'package:cortexia/features/case_history/domain/repo/repo_interface.dart';
import 'package:cortexia/features/case_history/presentation/controllers/case_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaseHistoryScreen extends StatelessWidget {
  final String admissionId;

  const CaseHistoryScreen({super.key,  this.admissionId="ADM-A61B43BAB7AD"});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CaseHistoryCubit(locator<CaseHistoryRepoInterface>())
            ..getAdmissionsAdmissionidCaseHistory(admissionid: admissionId),
      child: const _CaseHistoryView(),
    );
  }
}

class _CaseHistoryView extends StatelessWidget {
  const _CaseHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Case History'),
      body: BlocListener<CaseHistoryCubit, CaseHistoryState>(
        listener: (context, state) {
          if (state is CaseHistoryStateSuccess &&
              state.operation == 'postAdmissionsAdmissionidCaseHistory') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Case history saved successfully.'),
                backgroundColor: AppColors.successGreen,
              ),
            );
          } else if (state is CaseHistoryStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        child: BlocBuilder<CaseHistoryCubit, CaseHistoryState>(
          builder: (context, state) {
            if (state is CaseHistoryStateLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              );
            }
            return const _CaseHistoryContent();
          },
        ),
      ),
    );
  }
}

class _CaseHistoryContent extends StatelessWidget {
  const _CaseHistoryContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppDimens.paddingAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CaseHistorySummaryCard(),
          SizedBox(height: AppDimens.space16),
          _CaseHistoryInfoSection(),
          SizedBox(height: AppDimens.space24),
          _CaseHistoryAddForm(),
          SizedBox(height: AppDimens.space24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Summary card at top
// ─────────────────────────────────────────────
class _CaseHistorySummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1E88E5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppDimens.radius16,
      ),
      child: Row(
        children: [
          Container(
            padding: AppDimens.paddingAll12,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.assignment_outlined,
              color: AppColors.white,
              size: 28,
            ),
          ),
          SizedBox(width: AppDimens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medical Case History',
                  style: TextStyle(
                    fontSize: AppDimens.fontTitle,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: AppDimens.space4),
                Text(
                  'Complete patient admission history',
                  style: TextStyle(
                    fontSize: AppDimens.fontSmall,
                    color: AppColors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Read-only Info Section (previously fetched data)
// ─────────────────────────────────────────────
class _CaseHistoryInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patient Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppDimens.space12),
        _InfoCard(
          icon: Icons.sick_outlined,
          label: 'Chief Complaint',
          value: 'Fever with shortness of breath (3 days)',
          color: Colors.red,
        ),
        SizedBox(height: AppDimens.space8),
        _InfoCard(
          icon: Icons.history_outlined,
          label: 'Present Illness',
          value:
              'Patient presented with high-grade fever up to 39.5°C, associated with progressive dyspnea and productive cough with greenish sputum.',
          color: Colors.orange,
        ),
        SizedBox(height: AppDimens.space8),
        _InfoCard(
          icon: Icons.monitor_heart_outlined,
          label: 'Chronic Diseases',
          value: 'Hypertension (10 years), Type II DM',
          color: Colors.purple,
        ),
        SizedBox(height: AppDimens.space8),
        _InfoCard(
          icon: Icons.family_restroom_outlined,
          label: 'Genetic / Family History',
          value: 'Father: Coronary artery disease. Mother: Breast cancer.',
          color: Colors.teal,
        ),
        SizedBox(height: AppDimens.space8),
        _InfoCard(
          icon: Icons.favorite_border_outlined,
          label: 'Marital History',
          value: 'Married, 3 children — no obstetric complications',
          color: Colors.pink,
        ),
        SizedBox(height: AppDimens.space8),
        _InfoCard(
          icon: Icons.smoking_rooms_outlined,
          label: 'Special Habits',
          value: 'Ex-smoker (quit 5 years ago). No alcohol or drug use.',
          color: Colors.brown,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius12,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: AppDimens.radius8,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: AppDimens.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppDimens.fontSmall,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppDimens.space4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppDimens.fontMedium,
                    color: AppColors.textMain,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Add / Edit Form
// ─────────────────────────────────────────────
class _CaseHistoryAddForm extends StatefulWidget {
  const _CaseHistoryAddForm();

  @override
  State<_CaseHistoryAddForm> createState() => _CaseHistoryAddFormState();
}

class _CaseHistoryAddFormState extends State<_CaseHistoryAddForm> {
  final _formKey = GlobalKey<FormState>();
  final _complaintCtrl = TextEditingController();
  final _presentIllnessCtrl = TextEditingController();
  final _chronicDiseaseCtrl = TextEditingController();
  final _geneticDiseaseCtrl = TextEditingController();
  final _maritalHistoryCtrl = TextEditingController();
  final _specialHabitsCtrl = TextEditingController();
  final _clinicalNotesCtrl = TextEditingController();

  @override
  void dispose() {
    _complaintCtrl.dispose();
    _presentIllnessCtrl.dispose();
    _chronicDiseaseCtrl.dispose();
    _geneticDiseaseCtrl.dispose();
    _maritalHistoryCtrl.dispose();
    _specialHabitsCtrl.dispose();
    _clinicalNotesCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final admissionId =
        context
            .findAncestorWidgetOfExactType<CaseHistoryScreen>()
            ?.admissionId ??
        '';
    context.read<CaseHistoryCubit>().postAdmissionsAdmissionidCaseHistory(
      admissionid: admissionId,
      requestBody: AddCaseHistoryCommandModel(
        complaint: _complaintCtrl.text.trim(),
        presentIllness: _presentIllnessCtrl.text.trim(),
        chronicDisease: _chronicDiseaseCtrl.text.trim(),
        geneticDisease: _geneticDiseaseCtrl.text.trim(),
        maritalHistory: _maritalHistoryCtrl.text.trim(),
        specialHabits: _specialHabitsCtrl.text.trim(),
        clinicalNotes: _clinicalNotesCtrl.text.trim(),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.add_circle_outline,
                  color: AppColors.primaryBlue,
                ),
                SizedBox(width: AppDimens.space8),
                Text(
                  'Add / Update Case History',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.space16),
            _buildField(
              label: 'Chief Complaint',
              controller: _complaintCtrl,
              hint: 'e.g. Chest pain, Fever…',
            ),
            SizedBox(height: AppDimens.space12),
            _buildField(
              label: 'Present Illness',
              controller: _presentIllnessCtrl,
              hint: 'Describe the current illness…',
              maxLines: 3,
            ),
            SizedBox(height: AppDimens.space12),
            _buildField(
              label: 'Chronic Diseases',
              controller: _chronicDiseaseCtrl,
              hint: 'e.g. Hypertension, DM…',
            ),
            SizedBox(height: AppDimens.space12),
            _buildField(
              label: 'Genetic / Family Diseases',
              controller: _geneticDiseaseCtrl,
              hint: 'e.g. Father: Cardiac disease…',
            ),
            SizedBox(height: AppDimens.space12),
            _buildField(
              label: 'Marital History',
              controller: _maritalHistoryCtrl,
              hint: 'Married / Single / Divorced…',
            ),
            SizedBox(height: AppDimens.space12),
            _buildField(
              label: 'Special Habits',
              controller: _specialHabitsCtrl,
              hint: 'e.g. Smoking, Alcohol…',
            ),
            SizedBox(height: AppDimens.space12),
            _buildField(
              label: 'Clinical Notes',
              controller: _clinicalNotesCtrl,
              hint: 'Additional clinical observations…',
              maxLines: 3,
            ),
            SizedBox(height: AppDimens.space20),
            BlocBuilder<CaseHistoryCubit, CaseHistoryState>(
              builder: (context, state) {
                final isLoading = state is CaseHistoryStateLoading;
                return CustomElevatedButton(
                  text: isLoading ? 'Saving…' : 'Save Case History',
                  onPressed: () => _submit(context),
                  backgroundColor: AppColors.primaryBlue,
                  textColor: AppColors.white,
                  height: AppDimens.buttonHeight,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: AppDimens.fontMedium,
            fontWeight: FontWeight.w600,
            color: AppColors.textMain,
          ),
        ),
        SizedBox(height: AppDimens.space4),
        CustomTextFormField(
          controller: controller,
          hintText: hint,
          validator: (val) =>
              (val == null || val.trim().isEmpty) ? 'Required' : null,
        ),
      ],
    );
  }
}
