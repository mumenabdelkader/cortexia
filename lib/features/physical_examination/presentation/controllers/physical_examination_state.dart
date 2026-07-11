part of 'physical_examination_cubit.dart';

@immutable
abstract class PhysicalExaminationState {}

class PhysicalExaminationStateInitial extends PhysicalExaminationState {}
class PhysicalExaminationStateLoading extends PhysicalExaminationState {}
class PhysicalExaminationStateSuccess extends PhysicalExaminationState {
  final dynamic data;
  final String operation;
  PhysicalExaminationStateSuccess({required this.operation, this.data});
}
class PhysicalExaminationStateError extends PhysicalExaminationState {
  final String message;
  PhysicalExaminationStateError({required this.message});
}
