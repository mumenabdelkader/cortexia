import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
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
        emit(VitalSignsStateSuccess(operation: 'postAdmissionsAdmissionidVitals', data: data));
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
        emit(VitalSignsStateSuccess(operation: 'getAdmissionsAdmissionidVitals', data: data));
      },
      onError: (error) {
        emit(VitalSignsStateError(message: error.messages.first));
      },
    );
  }

}
