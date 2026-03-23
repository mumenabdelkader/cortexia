part of 'medications_cubit.dart';

@immutable
abstract class MedicationsState {}

class MedicationsStateInitial extends MedicationsState {}
class MedicationsStateLoading extends MedicationsState {}
class MedicationsStatePrescribed extends MedicationsState {
  final PrescribeMedicationResponseModel data;
  MedicationsStatePrescribed({required this.data});
}
class MedicationsStateLoaded extends MedicationsState {
  final List<MedicationResponseModel> medications;
  MedicationsStateLoaded({required this.medications});
}
class MedicationsStateSuccess extends MedicationsState {
  final dynamic data;
  final String operation;
  MedicationsStateSuccess({required this.operation, this.data});
}
class MedicationsStateError extends MedicationsState {
  final String message;
  MedicationsStateError({required this.message});
}
