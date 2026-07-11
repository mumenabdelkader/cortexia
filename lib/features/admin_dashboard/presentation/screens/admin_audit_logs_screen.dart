import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/features/admin_dashboard/data/models/audit_log_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/paged_result_model.dart';
import 'package:cortexia/features/admin_dashboard/presentation/controllers/admin_audit_logs_cubit.dart';
import 'package:cortexia/features/admin_dashboard/presentation/widgets/admin_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AdminAuditLogsScreen extends StatefulWidget {
  const AdminAuditLogsScreen({super.key});

  @override
  State<AdminAuditLogsScreen> createState() => _AdminAuditLogsScreenState();
}

class _AdminAuditLogsScreenState extends State<AdminAuditLogsScreen> {
  final _userIdController = TextEditingController();
  String? _selectedTable;
  int? _expandedRow;

  static const List<String> _tableOptions = [
    'CaseHistory',
    'FluidBalance',
    'InterventionProcedure',
    'Medications',
    'NursingNotes',
    'PhysicalExamination',
    'VitalSigns',
  ];

  @override
  void initState() {
    super.initState();
    context.read<AdminAuditLogsCubit>().loadAuditLogs(page: 1);
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AdminSectionHeader(
            title: 'Audit Logs',
            subtitle: 'System-wide change history with full traceability',
          ),
          const SizedBox(height: 20),
          _buildFilterBar(),
          const SizedBox(height: 20),
          BlocBuilder<AdminAuditLogsCubit, AdminAuditLogsState>(
            builder: (context, state) {
              if (state is AdminAuditLogsLoading ||
                  state is AdminAuditLogsInitial) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(
                        color: AppColors.primaryBlue),
                  ),
                );
              }
              if (state is AdminAuditLogsError) {
                return _buildError(state.message);
              }
              if (state is AdminAuditLogsLoaded) {
                final result = state.pagedResult as AuditLogPagedResult;
                return _buildTable(result);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  // ── Filter Bar ─────────────────────────────────────────────────────────────

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Table filter
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedTable,
                  decoration: const InputDecoration(
                    labelText: 'Filter by Table',
                    prefixIcon: Icon(Icons.table_chart_outlined, size: 18),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: [
                    const DropdownMenuItem(
                        value: null, child: Text('All Tables')),
                    ..._tableOptions.map(
                      (t) => DropdownMenuItem(value: t, child: Text(t)),
                    ),
                  ],
                  onChanged: (val) => setState(() => _selectedTable = val),
                ),
              ),
              const SizedBox(width: 12),
              // User ID filter
              Expanded(
                child: TextField(
                  controller: _userIdController,
                  decoration: const InputDecoration(
                    labelText: 'Filter by User ID',
                    prefixIcon: Icon(Icons.person_search_outlined, size: 18),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Apply button
              FilledButton.icon(
                onPressed: _applyFilters,
                icon: const Icon(Icons.filter_list, size: 16),
                label: const Text('Apply'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Clear button
              OutlinedButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('Clear'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    context.read<AdminAuditLogsCubit>().applyFilter(
          tableName: _selectedTable,
          userId: _userIdController.text.trim().isEmpty
              ? null
              : _userIdController.text.trim(),
        );
  }

  void _clearFilters() {
    setState(() {
      _selectedTable = null;
      _userIdController.clear();
    });
    context.read<AdminAuditLogsCubit>().loadAuditLogs(
          page: 1,
          resetFilters: true,
        );
  }

  // ── Data Table ─────────────────────────────────────────────────────────────

  Widget _buildTable(AuditLogPagedResult result) {
    final cubit = context.read<AdminAuditLogsCubit>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'Showing ${result.items.length} of ${result.totalCount} records',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          // Table header
          _buildTableHeader(),
          const Divider(height: 1, color: AppColors.divider),
          // Rows
          if (result.items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Text(
                  'No audit logs found',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: result.items.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: AppColors.divider),
              itemBuilder: (_, i) =>
                  _buildLogRow(result.items[i], i),
            ),
          const Divider(height: 1, color: AppColors.divider),
          // Pagination
          _buildPagination(result, cubit),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: AppColors.scaffoldBg,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: const Row(
        children: [
          Expanded(flex: 1, child: _HeaderCell(label: 'ID')),
          Expanded(flex: 2, child: _HeaderCell(label: 'Entity')),
          Expanded(flex: 2, child: _HeaderCell(label: 'Entity ID')),
          Expanded(flex: 1, child: _HeaderCell(label: 'Action')),
          Expanded(flex: 2, child: _HeaderCell(label: 'User ID')),
          Expanded(flex: 2, child: _HeaderCell(label: 'Timestamp')),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildLogRow(AuditLogModel log, int index) {
    final isExpanded = _expandedRow == index;
    final actionColor = log.actionLabel == 'Create'
        ? AppColors.successGreen
        : log.actionLabel == 'Delete'
            ? AppColors.errorRed
            : AppColors.warningOrange;

    return Column(
      children: [
        InkWell(
          onTap: () => setState(
              () => _expandedRow = isExpanded ? null : index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text('#${log.id}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary))),
                Expanded(
                    flex: 2,
                    child: Text(log.entityName ?? '—',
                        style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textMain,
                            fontWeight: FontWeight.w500))),
                Expanded(
                    flex: 2,
                    child: Text(log.entityId ?? '—',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis)),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: actionColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      log.actionLabel,
                      style: TextStyle(
                          color: actionColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      log.userId != null
                          ? '${log.userId!.substring(0, 8)}...'
                          : 'System',
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      _formatTimestamp(log.timestamp),
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    )),
                SizedBox(
                  width: 40,
                  child: Icon(
                    isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expanded detail row
        if (isExpanded) _buildExpandedDetail(log),
      ],
    );
  }

  Widget _buildExpandedDetail(AuditLogModel log) {
    return Container(
      color: AppColors.infoBg,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (log.oldValue != null) ...[
            const Text('Old Value:',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.textMain)),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: SelectableText(
                log.oldValue!,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (log.newValue != null) ...[
            const Text('New Value:',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.textMain)),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: SelectableText(
                log.newValue!,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMain,
                    fontFamily: 'monospace'),
              ),
            ),
          ],
          if (log.oldValue == null && log.newValue == null)
            const Text('No value snapshot available.',
                style: TextStyle(
                    color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPagination(AuditLogPagedResult result, AdminAuditLogsCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: result.hasPreviousPage
                ? () => cubit.previousPage()
                : null,
            icon: const Icon(Icons.chevron_left),
            color: AppColors.primaryBlue,
          ),
          const SizedBox(width: 8),
          Text(
            'Page ${result.pageNumber} of ${result.totalPages}',
            style: const TextStyle(
                fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: result.hasNextPage
                ? () => cubit.nextPage(result.totalPages)
                : null,
            icon: const Icon(Icons.chevron_right),
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,
              size: 48, color: AppColors.errorRed),
          const SizedBox(height: 12),
          Text(message,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () =>
                context.read<AdminAuditLogsCubit>().loadAuditLogs(page: 1),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(String raw) {
    try {
      final dt = DateTime.parse(raw);
      return DateFormat('MMM d, HH:mm').format(dt);
    } catch (_) {
      return raw;
    }
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  const _HeaderCell({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }
}
