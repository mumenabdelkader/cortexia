import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_audit_logs_state.dart';

class AdminAuditLogsCubit extends Cubit<AdminAuditLogsState> {
  final AdminDashboardRepoInterface _repo;

  static const int _defaultPageSize = 15;

  int _currentPage = 1;
  String? _currentTable;
  String? _currentUserId;

  AdminAuditLogsCubit(this._repo) : super(AdminAuditLogsInitial());

  int get currentPage => _currentPage;
  String? get currentTable => _currentTable;
  String? get currentUserId => _currentUserId;

  Future<void> loadAuditLogs({
    int page = 1,
    String? tableName,
    String? userId,
    bool resetFilters = false,
  }) async {
    if (resetFilters) {
      _currentTable = null;
      _currentUserId = null;
      _currentPage = 1;
    } else {
      _currentPage = page;
      _currentTable = tableName ?? _currentTable;
      _currentUserId = userId ?? _currentUserId;
    }

    emit(AdminAuditLogsLoading());
    final result = await _repo.getAuditLogs(
      pageNumber: _currentPage,
      pageSize: _defaultPageSize,
      tableName: _currentTable,
      userId: _currentUserId,
    );
    result.when(
      onSuccess: (data) => emit(AdminAuditLogsLoaded(pagedResult: data)),
      onError: (error) =>
          emit(AdminAuditLogsError(message: error.messages.first)),
    );
  }

  Future<void> applyFilter({String? tableName, String? userId}) async {
    _currentTable = tableName;
    _currentUserId = userId;
    _currentPage = 1;
    await loadAuditLogs(page: 1, tableName: tableName, userId: userId);
  }

  Future<void> nextPage(int totalPages) async {
    if (_currentPage < totalPages) {
      await loadAuditLogs(page: _currentPage + 1);
    }
  }

  Future<void> previousPage() async {
    if (_currentPage > 1) {
      await loadAuditLogs(page: _currentPage - 1);
    }
  }
}
