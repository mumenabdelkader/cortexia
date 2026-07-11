import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_doctors_state.dart';

const String kCreateDoctor = 'createDoctor';
const String kUpdateDoctor = 'updateDoctor';

class AdminDoctorsCubit extends Cubit<AdminDoctorsState> {
  final AdminDashboardRepoInterface _repo;

  AdminDoctorsCubit(this._repo) : super(AdminDoctorsInitial());

  Future<void> getDoctors() async {
    emit(AdminDoctorsLoading());
    final result = await _repo.getDoctors();
    result.when(
      onSuccess: (doctors) => emit(AdminDoctorsLoaded(doctors)),
      onError: (error) => emit(AdminDoctorsError(message: error.messages.first)),
    );
  }

  Future<void> createDoctor(CreateUserRequest request) async {
    emit(AdminDoctorsLoading());
    final result = await _repo.createUser(request);
    result.when(
      onSuccess: (data) =>
          emit(AdminDoctorsSuccess(operation: kCreateDoctor, data: data)),
      onError: (error) => emit(AdminDoctorsError(message: error.messages.first)),
    );
  }

  Future<void> updateDoctor(String email, UpdateDoctorRequest request) async {
    emit(AdminDoctorsLoading());
    final result = await _repo.updateDoctor(email, request);
    result.when(
      onSuccess: (data) =>
          emit(AdminDoctorsSuccess(operation: kUpdateDoctor, data: data)),
      onError: (error) => emit(AdminDoctorsError(message: error.messages.first)),
    );
  }
}
