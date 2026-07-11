part of 'admin_beds_cubit.dart';

@immutable
abstract class AdminBedsState {}

class AdminBedsInitial extends AdminBedsState {}

class AdminBedsLoading extends AdminBedsState {}

class AdminBedsSuccess extends AdminBedsState {
  final String operation;
  final dynamic data;

  AdminBedsSuccess({required this.operation, this.data});
}

class AdminBedsError extends AdminBedsState {
  final String message;

  AdminBedsError({required this.message});
}
