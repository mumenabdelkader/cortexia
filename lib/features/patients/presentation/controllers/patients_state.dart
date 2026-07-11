part of 'patients_cubit.dart';

@immutable
abstract class PatientsState {}

class PatientsStateInitial extends PatientsState {}
class PatientsStateLoading extends PatientsState {}
class PatientsStateSuccess extends PatientsState {
  final dynamic data;
  final String operation;
  PatientsStateSuccess({required this.operation, this.data});
}
class PatientsStateError extends PatientsState {
  final String message;
  PatientsStateError({required this.message});
}
