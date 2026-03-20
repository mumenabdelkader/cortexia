part of 'diagnostics_cubit.dart';

@immutable
abstract class DiagnosticsState {}

class DiagnosticsStateInitial extends DiagnosticsState {}
class DiagnosticsStateLoading extends DiagnosticsState {}
class DiagnosticsStateSuccess extends DiagnosticsState {
  final dynamic data;
  final String operation;
  DiagnosticsStateSuccess({required this.operation, this.data});
}
class DiagnosticsStateError extends DiagnosticsState {
  final String message;
  DiagnosticsStateError({required this.message});
}
