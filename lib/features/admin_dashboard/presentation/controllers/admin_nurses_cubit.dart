import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/data/models/nurse_model.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_nurses_state.dart';

const String kCreateNurse = 'createNurse';
const String kUpdateNurse = 'updateNurse';

class AdminNursesCubit extends Cubit<AdminNursesState> {
  final AdminDashboardRepoInterface _repo;

  AdminNursesCubit(this._repo) : super(AdminNursesInitial());

  Future<void> getNurses() async {
    emit(AdminNursesLoading());
    final result = await _repo.getNurses();
    result.when(
      onSuccess: (nurses) => emit(AdminNursesLoaded(nurses)),
      onError: (error) => emit(AdminNursesError(message: error.messages.first)),
    );
  }

  Future<void> createNurse(CreateUserRequest request) async {
    emit(AdminNursesLoading());
    final result = await _repo.createUser(request);
    result.when(
      onSuccess: (data) =>
          emit(AdminNursesSuccess(operation: kCreateNurse, data: data)),
      onError: (error) => emit(AdminNursesError(message: error.messages.first)),
    );
  }

  Future<void> updateNurse(String email, UpdateNurseRequest request) async {
    emit(AdminNursesLoading());
    final result = await _repo.updateNurse(email, request);
    result.when(
      onSuccess: (data) =>
          emit(AdminNursesSuccess(operation: kUpdateNurse, data: data)),
      onError: (error) => emit(AdminNursesError(message: error.messages.first)),
    );
  }
}
