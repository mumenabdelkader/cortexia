part of 'case_history_cubit.dart';

@immutable
abstract class CaseHistoryState {}

class CaseHistoryStateInitial extends CaseHistoryState {}
class CaseHistoryStateLoading extends CaseHistoryState {}
class CaseHistoryStateSuccess extends CaseHistoryState {
  final dynamic data;
  final String operation;
  CaseHistoryStateSuccess({required this.operation, this.data});
}
class CaseHistoryStateError extends CaseHistoryState {
  final String message;
  CaseHistoryStateError({required this.message});
}
