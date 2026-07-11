part of 'vital_signs_cubit.dart';

@immutable
abstract class VitalSignsState {}

class VitalSignsStateInitial extends VitalSignsState {}
class VitalSignsStateLoading extends VitalSignsState {}
class VitalSignsStateSuccess extends VitalSignsState {
  final dynamic data;
  final String operation;
  VitalSignsStateSuccess({required this.operation, this.data});
}
class VitalSignsStateError extends VitalSignsState {
  final String message;
  VitalSignsStateError({required this.message});
}
