import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/core/themes/app_dimens.dart';
import 'package:cortexia/core/themes/color_themes.dart';
import 'package:cortexia/core/widgets/custom_app_bar.dart';
import 'package:cortexia/features/diagnostics/data/models/add_lab_result_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/create_lab_order_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/lab_order_model.dart';
import 'package:cortexia/features/diagnostics/data/models/lab_result_model.dart';
import 'package:cortexia/features/diagnostics/presentation/controllers/diagnostics_cubit.dart';

class LabResultsScreen extends StatefulWidget {
  final String admissionId;

  const LabResultsScreen({super.key, required this.admissionId});

  @override
  State<LabResultsScreen> createState() => _LabResultsScreenState();
}

class _LabResultsScreenState extends State<LabResultsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() {
    context.read<DiagnosticsCubit>().getDiagnosticsLabOrdersAdmissionid(
          admissionid: widget.admissionId,
        );
  }

  // ──────────────────────────────────────────
  //  Dialog: Create Lab Order
  // ──────────────────────────────────────────
  void _showCreateLabOrderDialog() {
    final testNameCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: AppDimens.radius16),
        title: Text(
          'New Lab Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimens.fontLarge,
            color: AppColors.textMain,
          ),
        ),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: testNameCtrl,
            decoration: InputDecoration(
              labelText: 'Test Name',
              border: OutlineInputBorder(
                  borderRadius: AppDimens.radius8),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
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

              await context.read<DiagnosticsCubit>().postDiagnosticsLabOrders(
                    requestBody: CreateLabOrderCommandModel(
                      admissionId: widget.admissionId,
                      testName: testNameCtrl.text.trim(),
                      orderDate: DateTime.now().toUtc().toIso8601String(),
                      doctorId: userData?.userIdInSystem,
                    ),
                  );
              if (!mounted) return;
              _fetchOrders();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  //  Dialog: Add Lab Result (specific order)
  // ──────────────────────────────────────────
  void _showAddLabResultForOrder(LabOrderModel order) {
    final paramCtrl = TextEditingController();
    final valueCtrl = TextEditingController();
    final unitCtrl = TextEditingController();
    final refCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: AppDimens.radius16),
        title: Text(
          'Add Result — ${order.testName ?? order.id ?? 'Order'}',
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
                TextFormField(
                  controller: paramCtrl,
                  decoration: InputDecoration(
                    labelText: 'Parameter (e.g. Hemoglobin)',
                    border: OutlineInputBorder(borderRadius: AppDimens.radius8),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                SizedBox(height: AppDimens.space12),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: valueCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Value',
                          border: OutlineInputBorder(
                              borderRadius: AppDimens.radius8),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Required';
                          if (double.tryParse(v.trim()) == null) {
                            return 'Must be a number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: AppDimens.space8),
                    Expanded(
                      child: TextFormField(
                        controller: unitCtrl,
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          border: OutlineInputBorder(
                              borderRadius: AppDimens.radius8),
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.space12),
                TextFormField(
                  controller: refCtrl,
                  decoration: InputDecoration(
                    labelText: 'Reference Range (e.g. 13.0 - 17.0)',
                    border: OutlineInputBorder(borderRadius: AppDimens.radius8),
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
              await context.read<DiagnosticsCubit>().postDiagnosticsLabResults(
                    requestBody: AddLabResultCommandModel(
                      labOrderId: order.id,
                      parameter: paramCtrl.text.trim(),
                      value: double.parse(valueCtrl.text.trim()),
                      unit: unitCtrl.text.trim(),
                      referenceRange: refCtrl.text.trim(),
                      sampleDate: DateTime.now().toUtc().toIso8601String(),
                      nurseId: userData?.userIdInSystem,
                    ),
                  );
              if (!mounted) return;
              _fetchOrders();
            },
            child: const Text('Add Result'),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────
  //  Dialog: Add Lab Result to an Order
  // ──────────────────────────────────────────
  void _showAddLabResultDialog(List<LabOrderModel> orders) {
    final paramCtrl = TextEditingController();
    final valueCtrl = TextEditingController();
    final unitCtrl = TextEditingController();
    final refCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    LabOrderModel? selectedOrder = orders.isNotEmpty ? orders.first : null;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInner) => AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: AppDimens.radius16),
          title: Text(
            'Add Lab Result',
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
                  // Lab Order selector
                  DropdownButtonFormField<LabOrderModel>(
                    value: selectedOrder,
                    decoration: InputDecoration(
                      labelText: 'Lab Order',
                      border: OutlineInputBorder(
                          borderRadius: AppDimens.radius8),
                    ),
                    items: orders
                        .map((o) => DropdownMenuItem(
                              value: o,
                              child: Text(
                                o.testName ?? o.id ?? '—',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (v) => setInner(() => selectedOrder = v),
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  SizedBox(height: AppDimens.space12),
                  TextFormField(
                    controller: paramCtrl,
                    decoration: InputDecoration(
                      labelText: 'Parameter (e.g. Hemoglobin)',
                      border: OutlineInputBorder(
                          borderRadius: AppDimens.radius8),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  SizedBox(height: AppDimens.space12),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: valueCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Value',
                            border: OutlineInputBorder(
                                borderRadius: AppDimens.radius8),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            if (double.tryParse(v.trim()) == null) {
                              return 'Must be a number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: AppDimens.space8),
                      Expanded(
                        child: TextFormField(
                          controller: unitCtrl,
                          decoration: InputDecoration(
                            labelText: 'Unit',
                            border: OutlineInputBorder(
                                borderRadius: AppDimens.radius8),
                          ),
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimens.space12),
                  TextFormField(
                    controller: refCtrl,
                    decoration: InputDecoration(
                      labelText: 'Reference Range (e.g. 13.0 - 17.0)',
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

                await context
                    .read<DiagnosticsCubit>()
                    .postDiagnosticsLabResults(
                      requestBody: AddLabResultCommandModel(
                        labOrderId: selectedOrder!.id,
                        parameter: paramCtrl.text.trim(),
                        value: double.parse(valueCtrl.text.trim()),
                        unit: unitCtrl.text.trim(),
                        referenceRange: refCtrl.text.trim(),
                        sampleDate: DateTime.now().toUtc().toIso8601String(),
                        nurseId: userData?.userIdInSystem,
                      ),
                    );
                if (!mounted) return;
                _fetchOrders();
              },
              child: const Text('Add Result'),
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
      appBar: const CustomAppBar(title: 'Laboratory Results'),
      floatingActionButton: _buildFab(),
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
                        fontSize: AppDimens.fontMedium,
                      ),
                    ),
                    SizedBox(height: AppDimens.space16),
                    ElevatedButton.icon(
                      onPressed: _fetchOrders,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is DiagnosticsLabOrdersLoaded) {
            final orders = state.labOrders;

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.science_outlined,
                        size: 64, color: AppColors.textSecondary),
                    SizedBox(height: AppDimens.space16),
                    Text(
                      'No lab orders yet',
                      style: TextStyle(
                        fontSize: AppDimens.fontLarge,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppDimens.space8),
                    Text(
                      'Tap + to create the first order',
                      style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: AppDimens.paddingAll16,
              child: Column(
                children: [
                  _buildTopSummaryCard(orders),
                  SizedBox(height: AppDimens.space16),
                  ...orders.map(
                    (order) => Padding(
                      padding: EdgeInsets.only(bottom: AppDimens.space16),
                      child: InkWell(
                        onTap: () => _showAddLabResultForOrder(order),
                        borderRadius: AppDimens.radius16,
                        child: _buildLabOrderCard(order),
                      ),
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
  //  FAB with speed dial
  // ──────────────────────────────────────────
  Widget _buildFab() {
    return BlocBuilder<DiagnosticsCubit, DiagnosticsState>(
      builder: (context, state) {
        final orders = state is DiagnosticsLabOrdersLoaded
            ? state.labOrders
            : <LabOrderModel>[];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (orders.isNotEmpty) ...[
              FloatingActionButton.extended(
                heroTag: 'addResult',
                onPressed: () => _showAddLabResultDialog(orders),
                icon: const Icon(Icons.add_chart),
                label: const Text('Add Result'),
                backgroundColor: AppColors.infoBlue,
              ),
              SizedBox(height: AppDimens.space12),
            ],
            FloatingActionButton.extended(
              heroTag: 'newOrder',
              onPressed: _showCreateLabOrderDialog,
              icon: const Icon(Icons.add),
              label: const Text('New Order'),
              backgroundColor: AppColors.successGreen,
            ),
          ],
        );
      },
    );
  }

  // ──────────────────────────────────────────
  //  UI helpers (carried over)
  // ──────────────────────────────────────────
  Widget _buildTopSummaryCard(List<LabOrderModel> orders) {
    final latestOrder = orders.first;
    final displayDate = _formatDate(latestOrder.orderDate ?? '');
    final totalResults = orders.fold<int>(
        0, (sum, o) => sum + (o.results?.length ?? 0));

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
            child: Icon(Icons.science,
                color: AppColors.infoBlue, size: AppDimens.iconSize),
          ),
          SizedBox(width: AppDimens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Last Order',
                    style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.textSecondary)),
                SizedBox(height: AppDimens.space4),
                Text(displayDate,
                    style: TextStyle(
                        fontSize: AppDimens.fontMedium,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.space12, vertical: AppDimens.space8),
            decoration: BoxDecoration(
              color: AppColors.infoBlue.withValues(alpha: 0.1),
              borderRadius: AppDimens.radius8,
            ),
            child: Text(
              '$totalResults Results',
              style: TextStyle(
                  color: AppColors.infoBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimens.fontSmall),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabOrderCard(LabOrderModel order) {
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
                Expanded(
                  child: Text(order.testName ?? 'Unknown Test',
                      style: TextStyle(
                          fontSize: AppDimens.fontLarge,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMain)),
                ),
                Text(_formatDate(order.orderDate ?? ''),
                    style: TextStyle(
                        fontSize: AppDimens.fontSmall,
                        color: AppColors.textSecondary)),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.border),
          if (order.results == null || order.results!.isEmpty)
            Padding(
              padding: AppDimens.paddingAll16,
              child: Text('No results yet.',
                  style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimens.fontSmall)),
            )
          else
            ...order.results!.asMap().entries.map((entry) {
              final isLast = entry.key == order.results!.length - 1;
              return _buildLabResultItem(entry.value, isLastItem: isLast);
            }),
        ],
      ),
    );
  }

  Widget _buildLabResultItem(LabResultModel result, {bool isLastItem = false}) {
    final status = _computeStatus(result);
    final valueStr = result.value != null ? result.value!.toString() : '--';

    return Column(
      children: [
        Padding(
          padding: AppDimens.paddingAll16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(result.parameter ?? '--',
                          style: TextStyle(
                              fontSize: AppDimens.fontMedium,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMain)),
                      SizedBox(width: AppDimens.space8),
                      _buildStatusBadge(status),
                    ]),
                    SizedBox(height: AppDimens.space4),
                    Text('Ref: ${result.referenceRange ?? 'N/A'}',
                        style: TextStyle(
                            fontSize: AppDimens.fontSmall,
                            color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(valueStr,
                      style: TextStyle(
                          fontSize: AppDimens.fontXLarge,
                          fontWeight: FontWeight.bold,
                          color: _getValueColor(status))),
                  const SizedBox(width: 4),
                  Text(result.unit ?? '',
                      style: TextStyle(
                          fontSize: AppDimens.fontSmall,
                          color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
        ),
        if (!isLastItem) Divider(height: 1, color: AppColors.border),
      ],
    );
  }

  String _computeStatus(LabResultModel result) {
    if (result.value == null || result.referenceRange == null) return 'Unknown';
    final parts = result.referenceRange!.split('-');
    if (parts.length < 2) return 'Normal';
    final min = double.tryParse(parts[0].trim());
    final max = double.tryParse(parts[1].trim());
    if (min == null || max == null) return 'Normal';
    if (result.value! < min) return 'Low ↓';
    if (result.value! > max) return 'High ↑';
    return 'Normal';
  }

  Color _getValueColor(String status) {
    if (status.contains('High')) return AppColors.errorRed;
    if (status.contains('Low')) return AppColors.warningOrange;
    return AppColors.textMain;
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    if (status.contains('Normal')) {
      bgColor = AppColors.successGreen.withValues(alpha: 0.1);
      textColor = AppColors.successGreen;
    } else if (status.contains('High')) {
      bgColor = AppColors.errorRed.withValues(alpha: 0.1);
      textColor = AppColors.errorRed;
    } else if (status.contains('Low')) {
      bgColor = AppColors.warningOrange.withValues(alpha: 0.1);
      textColor = AppColors.warningOrange;
    } else {
      bgColor = AppColors.infoBlue.withValues(alpha: 0.1);
      textColor = AppColors.infoBlue;
    }
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: AppDimens.space8, vertical: 2),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: AppDimens.radius8),
      child: Text(status,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: textColor)),
    );
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
