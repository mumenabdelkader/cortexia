part of 'medications_cubit.dart';

@immutable
abstract class MedicationsState {}

class MedicationsStateInitial extends MedicationsState {}
class MedicationsStateLoading extends MedicationsState {}
class MedicationsStateSuccess extends MedicationsState {
  final dynamic data;
  final String operation;
  MedicationsStateSuccess({required this.operation, this.data});
}
class MedicationsStateError extends MedicationsState {
  final String message;
  MedicationsStateError({required this.message});
}
