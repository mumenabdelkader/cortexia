part of 'nursing_notes_cubit.dart';

@immutable
abstract class NursingNotesState {}

class NursingNotesStateInitial extends NursingNotesState {}
class NursingNotesStateLoading extends NursingNotesState {}
class NursingNotesStateSuccess extends NursingNotesState {
  final dynamic data;
  final String operation;
  NursingNotesStateSuccess({required this.operation, this.data});
}
class NursingNotesStateError extends NursingNotesState {
  final String message;
  NursingNotesStateError({required this.message});
}
