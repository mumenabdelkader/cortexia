part of 'admin_users_cubit.dart';

@immutable
abstract class AdminUsersState {}

class AdminUsersInitial extends AdminUsersState {}

class AdminUsersLoading extends AdminUsersState {}

class AdminUsersSuccess extends AdminUsersState {
  final String operation;
  final dynamic data;

  AdminUsersSuccess({required this.operation, this.data});
}

class AdminUsersError extends AdminUsersState {
  final String message;

  AdminUsersError({required this.message});
}
