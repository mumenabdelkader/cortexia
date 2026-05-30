part of 'admin_audit_logs_cubit.dart';

@immutable
abstract class AdminAuditLogsState {}

class AdminAuditLogsInitial extends AdminAuditLogsState {}

class AdminAuditLogsLoading extends AdminAuditLogsState {}

class AdminAuditLogsLoaded extends AdminAuditLogsState {
  final dynamic pagedResult;

  AdminAuditLogsLoaded({required this.pagedResult});
}

class AdminAuditLogsError extends AdminAuditLogsState {
  final String message;

  AdminAuditLogsError({required this.message});
}
