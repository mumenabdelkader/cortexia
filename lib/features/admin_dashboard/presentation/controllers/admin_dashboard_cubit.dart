import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  final AdminDashboardRepoInterface _repo;

  AdminDashboardCubit(this._repo) : super(AdminDashboardInitial());

  Future<void> getSummary() async {
    emit(AdminDashboardLoading());
    final result = await _repo.getDashboardSummary();
    result.when(
      onSuccess: (data) => emit(AdminDashboardSuccess(
        operation: 'getSummary',
        data: data,
      )),
      onError: (error) =>
          emit(AdminDashboardError(message: error.messages.first)),
    );
  }
}
