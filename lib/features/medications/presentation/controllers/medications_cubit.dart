import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/medications/domain/repo/repo_interface.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';
import 'package:cortexia/features/medications/data/models/medication_response_model.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_response_model.dart';

part 'medications_state.dart';

class MedicationsCubit extends Cubit<MedicationsState> {
  final MedicationsRepoInterface _repo;

  MedicationsCubit(this._repo) : super(MedicationsStateInitial());

  Future<void> postAdmissionsAdmissionidMedications({required String admissionid, required PrescribeMedicationCommandModel requestBody}) async {
    emit(MedicationsStateLoading());
    final response = await _repo.postAdmissionsAdmissionidMedications(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(MedicationsStatePrescribed(data: data));
      },
      onError: (error) {
        emit(MedicationsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidMedications({required String admissionid}) async {
    emit(MedicationsStateLoading());
    final response = await _repo.getAdmissionsAdmissionidMedications(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(MedicationsStateLoaded(medications: data));
      },
      onError: (error) {
        emit(MedicationsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> putAdmissionsAdmissionidMedications({required String admissionid, required PrescribeMedicationCommandModel requestBody}) async {
    emit(MedicationsStateLoading());
    final response = await _repo.putAdmissionsAdmissionidMedications(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(MedicationsStateSuccess(operation: 'put', data: data));
      },
      onError: (error) {
        emit(MedicationsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> deleteAdmissionsAdmissionidMedications({required String admissionid, required String id}) async {
    emit(MedicationsStateLoading());
    final response = await _repo.deleteAdmissionsAdmissionidMedications(admissionid: admissionid, id: id);
    response.when(
      onSuccess: (data) {
        emit(MedicationsStateSuccess(operation: 'delete', data: data));
      },
      onError: (error) {
        emit(MedicationsStateError(message: error.messages.first));
      },
    );
  }

}
