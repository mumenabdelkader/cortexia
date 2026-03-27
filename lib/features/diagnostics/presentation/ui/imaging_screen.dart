import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/features/diagnostics/data/models/imaging_model.dart';
import 'package:cortexia/features/diagnostics/data/models/upload_imaging_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/imaging_type.dart';
import 'package:cortexia/features/diagnostics/presentation/controllers/diagnostics_cubit.dart';

class ImagingScreen extends StatefulWidget {
  final String admissionId;

  const ImagingScreen({super.key, required this.admissionId});

  @override
  State<ImagingScreen> createState() => _ImagingScreenState();
}

class _ImagingScreenState extends State<ImagingScreen> {
  @override
  void initState() {
    super.initState();
    _fetchImaging();
  }

  void _fetchImaging() {
    context.read<DiagnosticsCubit>().getDiagnosticsImagingAdmissionid(
          admissionid: widget.admissionId,
        );
  }

  // ──────────────────────────────────────────
  //  Dialog: Upload Imaging
  // ──────────────────────────────────────────
  void _showUploadImagingDialog() {
    final findingsCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    ImagingType selectedType = ImagingType.value1; // Chest X-Ray default

    final typeLabels = {
      ImagingType.value0: 'X-Ray',
      ImagingType.value1: 'Chest X-Ray',
      ImagingType.value2: 'CT Scan',
      ImagingType.value3: 'MRI',
      ImagingType.value4: 'Ultrasound',
      ImagingType.value5: 'PET Scan',
    };

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInner) => AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: AppDimens.radius16),
          title: Text(
            'Upload Imaging Study',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.fontLarge,
              color: AppColors.textMain,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<ImagingType>(
                    value: selectedType,
                    decoration: InputDecoration(
                      labelText: 'Imaging Type',
                      border: OutlineInputBorder(
                          borderRadius: AppDimens.radius8),
                    ),
                    items: typeLabels.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ))
                        .toList(),
                    onChanged: (v) => setInner(() => selectedType = v!),
                  ),
                  SizedBox(height: AppDimens.space12),
                  TextFormField(
                    controller: findingsCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Findings',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: AppDimens.radius8),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                Navigator.pop(ctx);

                final userData = await AppCache.getUserData();
                if (!mounted) return;

                await context.read<DiagnosticsCubit>().postDiagnosticsImaging(
                      requestBody: UploadImagingCommandModel(
                        admissionId: widget.admissionId,
                        type: selectedType,
                        findings: findingsCtrl.text.trim(),
                        date: DateTime.now().toUtc().toIso8601String(),
                        doctorId: userData?.userIdInSystem,
                      ),
                    );
                if (!mounted) return;
                _fetchImaging();
              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────
  //  Build
  // ──────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(
        title: 'Imaging',
        subtitle: 'Radiology & Scans',
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uploadImaging',
        onPressed: _showUploadImagingDialog,
        icon: const Icon(Icons.add_photo_alternate_outlined),
        label: const Text('Upload Study'),
      ),
      body: BlocConsumer<DiagnosticsCubit, DiagnosticsState>(
        listener: (context, state) {
          if (state is DiagnosticsStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DiagnosticsStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DiagnosticsStateError) {
            return Center(
              child: Padding(
                padding: AppDimens.paddingAll16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48, color: AppColors.errorRed),
                    SizedBox(height: AppDimens.space16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.errorRed,
                          fontSize: AppDimens.fontMedium),
                    ),
                    SizedBox(height: AppDimens.space16),
                    ElevatedButton.icon(
                      onPressed: _fetchImaging,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is DiagnosticsImagingLoaded) {
            final imagingList = state.imagingList;

            if (imagingList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_search_outlined,
                        size: 64, color: AppColors.textSecondary),
                    SizedBox(height: AppDimens.space16),
                    Text('No imaging studies yet',
                        style: TextStyle(
                            fontSize: AppDimens.fontLarge,
                            color: AppColors.textSecondary)),
                    SizedBox(height: AppDimens.space8),
                    Text('Tap + to upload the first study',
                        style: TextStyle(
                            fontSize: AppDimens.fontSmall,
                            color: AppColors.textSecondary)),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: AppDimens.paddingAll16,
              child: Column(
                children: [
                  _buildSummaryCard(imagingList),
                  SizedBox(height: AppDimens.space16),
                  ...imagingList.map(
                    (img) => Padding(
                      padding: EdgeInsets.only(bottom: AppDimens.space16),
                      child: _buildImagingCard(img),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // ──────────────────────────────────────────
  //  UI helpers
  // ──────────────────────────────────────────
  Widget _buildSummaryCard(List<ImagingModel> imagingList) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: AppDimens.paddingAll12,
            decoration: BoxDecoration(
              color: AppColors.infoBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.image_outlined,
                color: AppColors.infoBlue, size: AppDimens.iconSize),
          ),
          SizedBox(width: AppDimens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Studies',
                    style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.textSecondary)),
                SizedBox(height: AppDimens.space4),
                Text(
                  '${imagingList.length} imaging ${imagingList.length == 1 ? 'study' : 'studies'}',
                  style: TextStyle(
                      fontSize: AppDimens.fontMedium,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMain),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.space12, vertical: AppDimens.space8),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withValues(alpha: 0.1),
              borderRadius: AppDimens.radius8,
            ),
            child: Text('Completed',
                style: TextStyle(
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimens.fontSmall)),
          ),
        ],
      ),
    );
  }

  Widget _buildImagingCard(ImagingModel imaging) {
    final typeName = _imagingTypeName(imaging.type);
    final typeIcon = _imagingTypeIcon(imaging.type);
    final dateDisplay = _formatDate(imaging.date ?? '');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDimens.radius16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppDimens.paddingAll16,
            child: Row(
              children: [
                Container(
                  padding: AppDimens.paddingAll12,
                  decoration: BoxDecoration(
                    color: AppColors.infoBlue.withValues(alpha: 0.1),
                    borderRadius: AppDimens.radius8,
                  ),
                  child: Icon(typeIcon,
                      color: AppColors.infoBlue, size: AppDimens.iconSize),
                ),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(typeName,
                          style: TextStyle(
                              fontSize: AppDimens.fontLarge,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textMain)),
                      SizedBox(height: AppDimens.space4),
                      Text(dateDisplay,
                          style: TextStyle(
                              fontSize: AppDimens.fontSmall,
                              color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.space8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withValues(alpha: 0.1),
                    borderRadius: AppDimens.radius8,
                  ),
                  child: Text('Completed',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.successGreen)),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.border),
          Padding(
            padding: AppDimens.paddingAll16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Findings',
                    style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5)),
                SizedBox(height: AppDimens.space8),
                Text(imaging.findings ?? 'No findings recorded.',
                    style: TextStyle(
                        fontSize: AppDimens.fontMedium,
                        color: AppColors.textMain,
                        height: 1.5)),
              ],
            ),
          ),
          if (imaging.id != null) ...[
            Divider(height: 1, color: AppColors.border),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.space16, vertical: AppDimens.space8),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(imaging.id!,
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _imagingTypeName(int? type) {
    switch (type) {
      case 0: return 'X-Ray';
      case 1: return 'Chest X-Ray';
      case 2: return 'CT Scan';
      case 3: return 'MRI';
      case 4: return 'Ultrasound';
      case 5: return 'PET Scan';
      default: return 'Imaging Study';
    }
  }

  IconData _imagingTypeIcon(int? type) {
    switch (type) {
      case 2: return Icons.circle_outlined;
      case 3: return Icons.blur_on_outlined;
      case 4: return Icons.water_drop_outlined;
      case 5: return Icons.radar;
      default: return Icons.image_outlined;
    }
  }

  String _formatDate(String isoDate) {
    if (isoDate.isEmpty) return 'N/A';
    try {
      final dt = DateTime.parse(isoDate);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return isoDate;
    }
  }
}