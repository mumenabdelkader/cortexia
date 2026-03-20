part of 'intervention_procedures_cubit.dart';

@immutable
abstract class InterventionProceduresState {}

class InterventionProceduresStateInitial extends InterventionProceduresState {}
class InterventionProceduresStateLoading extends InterventionProceduresState {}
class InterventionProceduresStateSuccess extends InterventionProceduresState {
  final dynamic data;
  final String operation;
  InterventionProceduresStateSuccess({required this.operation, this.data});
}
class InterventionProceduresStateError extends InterventionProceduresState {
  final String message;
  InterventionProceduresStateError({required this.message});
}
