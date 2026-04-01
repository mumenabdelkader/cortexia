import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/di/dependency_injection.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/core/widgets/custom_elevated_button.dart';
import 'package:cortexia/core/widgets/custom_form_field.dart';
import 'package:cortexia/features/nursing_notes/data/models/add_nursing_note_command_model.dart';
import 'package:cortexia/features/nursing_notes/domain/repo/repo_interface.dart';
import 'package:cortexia/features/nursing_notes/presentation/controllers/nursing_notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ─────────────────────────────────────────────
// Entry point — provides Cubit and loads nurseId
// ─────────────────────────────────────────────
class ClinicalNotesScreen extends StatefulWidget {
  final String? admissionId;

  const ClinicalNotesScreen({super.key, this.admissionId});

  @override
  State<ClinicalNotesScreen> createState() => _ClinicalNotesScreenState();
}

class _ClinicalNotesScreenState extends State<ClinicalNotesScreen> {
  String _nurseId = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNurseId();
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (widget.admissionId == null || widget.admissionId!.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Admission ID is required')),
      );
    }

    return BlocProvider(
      create: (_) => NursingNotesCubit(
        locator<NursingNotesRepoInterface>(),
      )..getAdmissionsAdmissionidNursingNotes(admissionid: widget.admissionId!),
      child: _ClinicalNotesView(
        admissionId: widget.admissionId!,
        nurseId: _nurseId,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Main view — reacts to BLoC states
// ─────────────────────────────────────────────
class _ClinicalNotesView extends StatelessWidget {
  final String admissionId;
  final String nurseId;

  const _ClinicalNotesView({required this.admissionId, required this.nurseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CustomAppBar(title: 'Clinical Notes'),
      body: BlocListener<NursingNotesCubit, NursingNotesState>(
        listener: (context, state) {
          if (state is NursingNotesStateSuccess &&
              state.operation == 'postAdmissionsAdmissionidNursingNotes') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Note saved successfully.'),
                backgroundColor: AppColors.successGreen,
              ),
            );
            // Refresh the list after adding
            context
                .read<NursingNotesCubit>()
                .getAdmissionsAdmissionidNursingNotes(admissionid: admissionId);
          } else if (state is NursingNotesStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        child: BlocBuilder<NursingNotesCubit, NursingNotesState>(
          builder: (context, state) {
            final notes =
                (state is NursingNotesStateSuccess &&
                    state.operation == 'getAdmissionsAdmissionidNursingNotes' &&
                    state.data is List)
                ? List<Map<String, dynamic>>.from(
                    (state.data as List).map((e) => e as Map<String, dynamic>),
                  )
                : <Map<String, dynamic>>[];

            final isFetching = state is NursingNotesStateLoading;

            return SingleChildScrollView(
              padding: AppDimens.paddingAll16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary card
                  _SummaryCard(count: notes.length),
                  SizedBox(height: AppDimens.space16),

                  // Add note form
                  _AddNoteForm(admissionId: admissionId, nurseId: nurseId),
                  SizedBox(height: AppDimens.space24),

                  // Timeline header
                  Text(
                    'Timeline',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppDimens.space16),

                  // Notes list
                  if (isFetching)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryBlue,
                      ),
                    )
                  else if (notes.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'No notes found.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ...notes.map(
                      (note) => _NoteCard(
                        note: note,
                        admissionId: admissionId,
                        nurseId: nurseId,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Summary card
// ─────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  final int count;
  const _SummaryCard({required this.count});

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Container(
                padding: AppDimens.paddingAll12,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.note_alt_outlined,
                  color: AppColors.primaryBlue,
                ),
              ),
              SizedBox(width: AppDimens.space12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: AppDimens.fontTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    'Total Notes',
                    style: TextStyle(
                      fontSize: AppDimens.fontMedium,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Add note form
// ─────────────────────────────────────────────
class _AddNoteForm extends StatefulWidget {
  final String admissionId;
  final String nurseId;

  const _AddNoteForm({required this.admissionId, required this.nurseId});

  @override
  State<_AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<_AddNoteForm> {
  final _formKey = GlobalKey<FormState>();
  final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();
    context.read<NursingNotesCubit>().postAdmissionsAdmissionidNursingNotes(
      admissionid: widget.admissionId,
      requestBody: AddNursingNoteCommandModel(
        admissionId: widget.admissionId,
        noteText: _noteCtrl.text.trim(),
        noteDateTime: now,
        nurseId: widget.nurseId,
      ),
    );
    _noteCtrl.clear();
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
                  'Add New Note',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.space12),
            CustomTextFormField(
              controller: _noteCtrl,
              hintText: 'Type your clinical note here...',
              maxLines: 3,
              validator: (val) =>
                  (val == null || val.trim().isEmpty) ? 'Required' : null,
            ),
            SizedBox(height: AppDimens.space16),
            BlocBuilder<NursingNotesCubit, NursingNotesState>(
              builder: (context, state) {
                final isSaving = state is NursingNotesStateLoading;
                return CustomElevatedButton(
                  text: isSaving ? 'Saving…' : 'Save Note',
                  onPressed: () => isSaving ? null : _submit(context),
                  height: AppDimens.buttonHeight,
                  backgroundColor: AppColors.primaryBlue,
                  textColor: AppColors.white,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Individual note card (from API)
// ─────────────────────────────────────────────
class _NoteCard extends StatelessWidget {
  final Map<String, dynamic> note;
  final String admissionId;
  final String nurseId;
  const _NoteCard({
    required this.note,
    required this.admissionId,
    required this.nurseId,
  });

  String _formatDateTime(String? raw) {
    if (raw == null) return '';
    try {
      final dt = DateTime.parse(raw).toLocal();
      final h = dt.hour.toString().padLeft(2, '0');
      final m = dt.minute.toString().padLeft(2, '0');
      return '${dt.day}/${dt.month}/${dt.year} • $h:$m';
    } catch (_) {
      return raw;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: AppDimens.paddingAll16,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppDimens.radius16,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                  child: const Icon(Icons.person, color: AppColors.primaryBlue),
                ),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note['nurseId'] ?? 'Nurse',
                        style: TextStyle(
                          fontSize: AppDimens.fontLarge,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: AppDimens.fontSmall,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: AppDimens.space4),
                          Text(
                            _formatDateTime(note['noteDateTime'] as String?),
                            style: TextStyle(
                              fontSize: AppDimens.fontSmall,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.space8,
                    vertical: AppDimens.space4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.1),
                    borderRadius: AppDimens.radius8,
                    border: Border.all(color: AppColors.successGreen),
                  ),
                  child: Text(
                    'Nursing Note',
                    style: TextStyle(
                      fontSize: AppDimens.fontSmall,
                      color: AppColors.successGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.textSecondary,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditNoteBottomSheet(context);
                    } else if (value == 'delete') {
                      _confirmDeleteNote(context);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: AppColors.primaryBlue,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: AppColors.errorRed,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: AppColors.errorRed),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
              ],
            ),
            SizedBox(height: AppDimens.space12),
            // Note text
            Text(
              note['noteText'] as String? ?? '',
              style: TextStyle(
                fontSize: AppDimens.fontMedium,
                color: AppColors.textMain,
                height: 1.5,
              ),
            ),
            SizedBox(height: AppDimens.space8),
            Text(
              'ID: ${note['id'] ?? ''}',
              style: TextStyle(
                fontSize: AppDimens.fontSmall,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text(
          'Are you sure you want to delete this clinical note?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context
                  .read<NursingNotesCubit>()
                  .deleteAdmissionsAdmissionidNursingNotes(
                    admissionid: admissionId,
                    id: note['id'] as String? ?? '',
                  );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BlocProvider.value(
          value: context.read<NursingNotesCubit>(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: _EditNoteBottomSheet(
              note: note,
              admissionId: admissionId,
              nurseId: nurseId,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Edit Note Bottom Sheet
// ─────────────────────────────────────────────
class _EditNoteBottomSheet extends StatefulWidget {
  final Map<String, dynamic> note;
  final String admissionId;
  final String nurseId;

  const _EditNoteBottomSheet({
    required this.note,
    required this.admissionId,
    required this.nurseId,
  });

  @override
  State<_EditNoteBottomSheet> createState() => _EditNoteBottomSheetState();
}

class _EditNoteBottomSheetState extends State<_EditNoteBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _noteCtrl;

  @override
  void initState() {
    super.initState();
    _noteCtrl = TextEditingController(
      text: widget.note['noteText'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context);
    final now = DateTime.now().toIso8601String();

    context.read<NursingNotesCubit>().putAdmissionsAdmissionidNursingNotes(
      admissionid: widget.admissionId,
      requestBody: AddNursingNoteCommandModel(
        id: widget.note['id'] as String?,
        admissionId: widget.admissionId,
        noteText: _noteCtrl.text.trim(),
        noteDateTime: now,
        nurseId: widget.nurseId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimens.paddingAll16,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Clinical Note',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space12),
              CustomTextFormField(
                controller: _noteCtrl,
                hintText: 'Type your clinical note here...',
                maxLines: 4,
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: AppDimens.space16),
              CustomElevatedButton(
                text: 'Update Note',
                onPressed: _submit,
                height: AppDimens.buttonHeight,
                backgroundColor: AppColors.primaryBlue,
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
