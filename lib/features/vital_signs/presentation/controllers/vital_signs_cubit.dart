import 'package:cortexia/features/vital_signs/presentation/controllers/vital_signs_opreations_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/vital_signs/domain/repo/repo_interface.dart';
import 'package:cortexia/features/vital_signs/data/models/record_vitals_command_model.dart';

part 'vital_signs_state.dart';

class VitalSignsCubit extends Cubit<VitalSignsState> {
  final VitalSignsRepoInterface _repo;

  VitalSignsCubit(this._repo) : super(VitalSignsStateInitial());

  Future<void> postAdmissionsAdmissionidVitals({required String admissionid, required RecordVitalsCommandModel requestBody}) async {
    emit(VitalSignsStateLoading());
    final response = await _repo.postAdmissionsAdmissionidVitals(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(VitalSignsStateSuccess(operation: kPostAdmissionsAdmissionidVitals, data: data));
      },
      onError: (error) {
        emit(VitalSignsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidVitals({required String admissionid}) async {
    emit(VitalSignsStateLoading());
    final response = await _repo.getAdmissionsAdmissionidVitals(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(VitalSignsStateSuccess(operation: kGetAdmissionsAdmissionidVitals, data: data));
      },
      onError: (error) {
        emit(VitalSignsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> putAdmissionsAdmissionidVitals({required String admissionid, required RecordVitalsCommandModel requestBody}) async {
    emit(VitalSignsStateLoading());
    final response = await _repo.putAdmissionsAdmissionidVitals(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(VitalSignsStateSuccess(operation: kPutAdmissionsAdmissionidVitals, data: data));
      },
      onError: (error) {
        emit(VitalSignsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> deleteAdmissionsAdmissionidVitals({required String admissionid, required String id}) async {
    emit(VitalSignsStateLoading());
    final response = await _repo.deleteAdmissionsAdmissionidVitals(admissionid: admissionid, id: id);
    response.when(
      onSuccess: (data) {
        emit(VitalSignsStateSuccess(operation: kDeleteAdmissionsAdmissionidVitals, data: data));
      },
      onError: (error) {
        emit(VitalSignsStateError(message: error.messages.first));
      },
    );
  }

}
