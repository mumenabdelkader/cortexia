part of 'admin_roles_cubit.dart';

@immutable
abstract class AdminRolesState {}

class AdminRolesInitial extends AdminRolesState {}

class AdminRolesLoading extends AdminRolesState {}

class AdminRolesSuccess extends AdminRolesState {
  final String operation;
  final dynamic data;

  AdminRolesSuccess({required this.operation, this.data});
}

class AdminRolesError extends AdminRolesState {
  final String message;

  AdminRolesError({required this.message});
}
