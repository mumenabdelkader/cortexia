import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:cortexia/features/fluid_balance/presentation/controllers/fluid_balance_cubit.dart';
import 'package:cortexia/features/fluid_balance/data/models/fluid_balance_category.dart';
import 'package:cortexia/features/fluid_balance/data/models/fluid_type.dart';
import 'package:cortexia/features/fluid_balance/data/models/add_fluid_balance_command_model.dart';

class FluidBalanceScreen extends StatefulWidget {
  final String? admissionId;
  final String? nurseId;

  const FluidBalanceScreen({super.key, this.admissionId, this.nurseId});

  @override
  State<FluidBalanceScreen> createState() => _FluidBalanceScreenState();
}

class _FluidBalanceScreenState extends State<FluidBalanceScreen> {
  String _nurseId = '';
  bool _isLoading = true;

  final Map<int, String> fluidTypeNames = {
    0: 'Oral',
    1: 'IV',
    2: 'Urine',
    3: 'Drain',
  };

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _loadNurseId() async {
    final userData = await AppCache.getUserData();
    if (mounted) {
      setState(() {
        _nurseId = userData?.userIdInSystem ?? '';
        _isLoading = false;
      });
    }
  }

  void _fetchData() {
    context.read<FluidBalanceCubit>().getAdmissionsAdmissionidFluidBalance(
      admissionid: widget.admissionId!,
    );
  }

  void _confirmDelete(BuildContext ctx, dynamic entry) {
    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete Fluid Record'),
        content: const Text('Are you sure you want to delete this record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              context
                  .read<FluidBalanceCubit>()
                  .deleteAdmissionsAdmissionidFluidBalance(
                    admissionid: widget.admissionId!,
                    id: entry['id'] as String? ?? '',
                  );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Fluid Balance Tracker'),
      body: BlocConsumer<FluidBalanceCubit, FluidBalanceState>(
        listener: (context, state) {
          if (state is FluidBalanceStateSuccess && state.operation != 'get') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Operation ${state.operation} successful'),
              ),
            );
            _fetchData();
          } else if (state is FluidBalanceStateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          if (state is FluidBalanceStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<dynamic> inputs = [];
          List<dynamic> outputs = [];
          int totalInput = 0;
          int totalOutput = 0;

          if (state is FluidBalanceStateSuccess && state.operation == 'get') {
            final data = state.data as List<dynamic>? ?? [];
            for (var item in data) {
              int amount = (item['amountMl'] as num?)?.toInt() ?? 0;
              // JSON parses category enum usually as index if it's int, or exact string
              bool isInput =
                  item['category'] == 0 || item['category'] == 'Intake';

              if (isInput) {
                inputs.add(item);
                totalInput += amount;
              } else {
                outputs.add(item);
                totalOutput += amount;
              }
            }
          }

          int netBalance = totalInput - totalOutput;

          return SingleChildScrollView(
            padding: AppDimens.paddingAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPatientHeader(),
                SizedBox(height: AppDimens.space16),
                _buildSummaryCards(totalInput, totalOutput, netBalance),
                SizedBox(height: AppDimens.space24),
                _buildFluidInputSection(context, inputs),
                SizedBox(height: AppDimens.space24),
                _buildFluidOutputSection(context, outputs),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fluid Balance Dashboard',
                style: TextStyle(
                  fontSize: AppDimens.fontLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              SizedBox(height: AppDimens.space4),
              Text(
                'Admission: ${widget.admissionId}',
                style: TextStyle(
                  fontSize: AppDimens.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Text(
            DateFormat('MMM d, yyyy').format(DateTime.now()),
            style: TextStyle(
              fontSize: AppDimens.fontSmall,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(int tInput, int tOutput, int net) {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            title: 'Total Input',
            value: '$tInput',
            unit: 'mL',
            icon: Icons.arrow_downward,
            color: AppColors.infoBlue,
          ),
        ),
        SizedBox(width: AppDimens.space8),
        Expanded(
          child: _buildSummaryCard(
            title: 'Total Output',
            value: '$tOutput',
            unit: 'mL',
            icon: Icons.arrow_upward,
            color: AppColors.warningOrange,
          ),
        ),
        SizedBox(width: AppDimens.space8),
        Expanded(
          child: _buildSummaryCard(
            title: 'Net Balance',
            value: '${net >= 0 ? '+' : ''}$net',
            unit: 'mL',
            icon: Icons.waves,
            color: net >= 0 ? AppColors.successGreen : AppColors.errorRed,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDimens.space16,
        horizontal: AppDimens.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: AppDimens.iconSize),
          SizedBox(height: AppDimens.space8),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: AppDimens.fontTitle,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFluidInputSection(BuildContext context, List<dynamic> inputs) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: AppColors.infoBlue,
                    size: AppDimens.iconSize,
                  ),
                  SizedBox(width: AppDimens.space8),
                  Text(
                    'Fluid Intake',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          if (inputs.isEmpty)
            const Text("No Intake Records")
          else
            ...inputs.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildRecordCard(e, isInput: true),
              ),
            ),
          SizedBox(height: AppDimens.space16),
          _buildAddRecordForm(context, isInput: true),
        ],
      ),
    );
  }

  Widget _buildFluidOutputSection(BuildContext context, List<dynamic> outputs) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.water_drop_outlined,
                    color: AppColors.warningOrange,
                    size: AppDimens.iconSize,
                  ),
                  SizedBox(width: AppDimens.space8),
                  Text(
                    'Fluid Output',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppDimens.space16),
          if (outputs.isEmpty)
            const Text("No Output Records")
          else
            ...outputs.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildRecordCard(e, isInput: false),
              ),
            ),
          SizedBox(height: AppDimens.space16),
          _buildAddRecordForm(context, isInput: false),
        ],
      ),
    );
  }

  Widget _buildRecordCard(dynamic entry, {required bool isInput}) {
    Color themeColor = isInput ? AppColors.infoBlue : AppColors.warningOrange;
    int typeIdx = entry['type'] is int ? entry['type'] : 0;
    String typeName = fluidTypeNames[typeIdx] ?? 'Unknown';
    String time = entry['recordedAt'] != null
        ? entry['recordedAt'].toString().split('T').last.split('.').first
        : '';

    return Container(
      padding: AppDimens.paddingAll12,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: AppDimens.radius12,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  typeName,
                  style: TextStyle(
                    fontSize: AppDimens.fontMedium,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMain,
                  ),
                ),
                SizedBox(height: AppDimens.space4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: AppDimens.fontSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '${entry['amountMl']} mL',
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              IconButton(
                onPressed: () => _confirmDelete(context, entry),
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddRecordForm(BuildContext context, {required bool isInput}) {
    final title = isInput ? 'Add New Intake' : 'Add New Output';
    final buttonText = isInput ? 'Save Intake' : 'Save Output';
    final themeColor = isInput ? AppColors.infoBlue : AppColors.warningOrange;

    final amountController = TextEditingController();
    int selectedTypeIdx = isInput
        ? 0
        : 2; // Default to Oral for Intake, Urine for Output

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: AppDimens.paddingAll16,
          decoration: BoxDecoration(
            color: isInput
                ? AppColors.infoBlue.withValues(alpha: 0.05)
                : AppColors.warningOrange.withValues(alpha: 0.05),
            borderRadius: AppDimens.radius12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppDimens.fontMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              SizedBox(height: AppDimens.space12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<int>(
                      value: selectedTypeIdx,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                      ),
                      items: fluidTypeNames.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() => selectedTypeIdx = val!);
                      },
                    ),
                  ),
                  SizedBox(width: AppDimens.space12),
                  Expanded(
                    flex: 1,
                    child: CustomTextFormField(
                      controller: amountController,
                      hintText: 'mL',
                      keyboardType: TextInputType.number,
                      fillColor: AppColors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space16),
              CustomElevatedButton(
                text: buttonText,
                onPressed: () {
                  final amount = int.tryParse(amountController.text);
                  if (amount == null) return;

                  final command = AddFluidBalanceCommandModel(
                    admissionId: widget.admissionId,
                    nurseId: widget.nurseId,
                    amountMl: amount,
                    category: isInput
                        ? FluidBalanceCategory.intake
                        : FluidBalanceCategory.output,
                    recordedAt: DateTime.now().toIso8601String(),
                    type: FluidType.values.firstWhere(
                      (e) => e.index == selectedTypeIdx,
                      orElse: () => FluidType.oral,
                    ),
                  );
                  context
                      .read<FluidBalanceCubit>()
                      .postAdmissionsAdmissionidFluidBalance(
                        admissionid: widget.admissionId!,
                        requestBody: command,
                      );
                },
                height: AppDimens.buttonHeight,
                backgroundColor: themeColor,
                textColor: AppColors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
