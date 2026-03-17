import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cortexia/features/fluid_balance/domain/repo/repo_interface.dart';
import 'package:cortexia/features/fluid_balance/data/models/add_fluid_balance_command_model.dart';

part 'fluid_balance_state.dart';

class FluidBalanceCubit extends Cubit<FluidBalanceState> {
  final FluidBalanceRepoInterface _repo;

  FluidBalanceCubit(this._repo) : super(FluidBalanceStateInitial());

  Future<void> postAdmissionsAdmissionidFluidBalance({required String admissionid, required AddFluidBalanceCommandModel requestBody}) async {
    emit(FluidBalanceStateLoading());
    final response = await _repo.postAdmissionsAdmissionidFluidBalance(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(FluidBalanceStateSuccess(operation: 'postAdmissionsAdmissionidFluidBalance', data: data));
      },
      onError: (error) {
        emit(FluidBalanceStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidFluidBalance({required String admissionid}) async {
    emit(FluidBalanceStateLoading());
    final response = await _repo.getAdmissionsAdmissionidFluidBalance(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(FluidBalanceStateSuccess(operation: 'getAdmissionsAdmissionidFluidBalance', data: data));
      },
      onError: (error) {
        emit(FluidBalanceStateError(message: error.messages.first));
      },
    );
  }

}
