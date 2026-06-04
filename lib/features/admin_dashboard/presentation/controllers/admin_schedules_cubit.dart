import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/data/models/schedule_model.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_schedules_state.dart';

const String kCreateSchedule = 'createSchedule';

class AdminSchedulesCubit extends Cubit<AdminSchedulesState> {
  final AdminDashboardRepoInterface _repo;

  AdminSchedulesCubit(this._repo) : super(AdminSchedulesInitial());

  Future<void> getStaffSchedules(String staffId) async {
    emit(AdminSchedulesLoading());
    final result = await _repo.getStaffSchedules(staffId);
    result.when(
      onSuccess: (schedules) => emit(AdminSchedulesLoaded(schedules)),
      onError: (error) => emit(AdminSchedulesError(message: error.messages.first)),
    );
  }

  Future<void> createStaffSchedule(String staffId, CreateScheduleRequest request) async {
    emit(AdminSchedulesLoading());
    final result = await _repo.createStaffSchedule(staffId, request);
    result.when(
      onSuccess: (data) => emit(AdminSchedulesSuccess(operation: kCreateSchedule, data: data)),
      onError: (error) => emit(AdminSchedulesError(message: error.messages.first)),
    );
  }
}
