part of 'admin_dashboard_cubit.dart';

@immutable
abstract class AdminDashboardState {}

class AdminDashboardInitial extends AdminDashboardState {}

class AdminDashboardLoading extends AdminDashboardState {}

class AdminDashboardSuccess extends AdminDashboardState {
  final String operation;
  final dynamic data;

  AdminDashboardSuccess({required this.operation, this.data});
}

class AdminDashboardError extends AdminDashboardState {
  final String message;

  AdminDashboardError({required this.message});
}
