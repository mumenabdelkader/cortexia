import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_beds_state.dart';

const String kCreateBed = 'createBed';
const String kUpdateBed = 'updateBed';
const String kDeleteBed = 'deleteBed';

class AdminBedsCubit extends Cubit<AdminBedsState> {
  final AdminDashboardRepoInterface _repo;

  AdminBedsCubit(this._repo) : super(AdminBedsInitial());

  Future<void> createBed({
    required String roomId,
    required String bedNumber,
  }) async {
    emit(AdminBedsLoading());
    final result = await _repo
        .createBed(CreateBedRequest(roomId: roomId, bedNumber: bedNumber));
    result.when(
      onSuccess: (data) =>
          emit(AdminBedsSuccess(operation: kCreateBed, data: data)),
      onError: (error) => emit(AdminBedsError(message: error.messages.first)),
    );
  }

  Future<void> updateBed({
    required String bedId,
    required String bedNumber,
    required int status,
  }) async {
    emit(AdminBedsLoading());
    final result = await _repo.updateBed(UpdateBedRequest(
      bedId: bedId,
      bedNumber: bedNumber,
      status: status,
    ));
    result.when(
      onSuccess: (data) =>
          emit(AdminBedsSuccess(operation: kUpdateBed, data: data)),
      onError: (error) => emit(AdminBedsError(message: error.messages.first)),
    );
  }

  Future<void> deleteBed(String bedId) async {
    emit(AdminBedsLoading());
    final result = await _repo.deleteBed(bedId);
    result.when(
      onSuccess: (data) =>
          emit(AdminBedsSuccess(operation: kDeleteBed, data: data)),
      onError: (error) => emit(AdminBedsError(message: error.messages.first)),
    );
  }
}
