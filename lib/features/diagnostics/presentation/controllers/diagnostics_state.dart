part of 'diagnostics_cubit.dart';

@immutable
abstract class DiagnosticsState {}

class DiagnosticsStateInitial extends DiagnosticsState {}

class DiagnosticsStateLoading extends DiagnosticsState {}

class DiagnosticsLabOrdersLoaded extends DiagnosticsState {
  final List<LabOrderModel> labOrders;
  DiagnosticsLabOrdersLoaded({required this.labOrders});
}

class DiagnosticsImagingLoaded extends DiagnosticsState {
  final List<ImagingModel> imagingList;
  DiagnosticsImagingLoaded({required this.imagingList});
}

class DiagnosticsStateSuccess extends DiagnosticsState {
  final dynamic data;
  final String operation;
  DiagnosticsStateSuccess({required this.operation, this.data});
}

class DiagnosticsStateError extends DiagnosticsState {
  final String message;
  DiagnosticsStateError({required this.message});
}
