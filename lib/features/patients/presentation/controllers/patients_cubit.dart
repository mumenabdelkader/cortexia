import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/patients/domain/repo/repo_interface.dart';
import 'package:cortexia/features/patients/data/models/create_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/get_all_patients_query_model.dart';
import 'package:cortexia/features/patients/data/models/update_patient_command_model.dart';

part 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  final PatientsRepoInterface _repo;

  PatientsCubit(this._repo) : super(PatientsStateInitial());

  Future<void> postPatients({required CreatePatientCommandModel requestBody}) async {
    emit(PatientsStateLoading());
    final response = await _repo.postPatients(requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(PatientsStateSuccess(operation: 'postPatients', data: data));
      },
      onError: (error) {
        emit(PatientsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getPatients({required GetAllPatientsQueryModel query}) async {
    emit(PatientsStateLoading());
    final response = await _repo.getPatients(query: query);
    response.when(
      onSuccess: (data) {
        emit(PatientsStateSuccess(operation: 'getPatients', data: data));
      },
      onError: (error) {
        emit(PatientsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> putPatientsId({required String id, required UpdatePatientCommandModel requestBody}) async {
    emit(PatientsStateLoading());
    final response = await _repo.putPatientsId(id: id, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(PatientsStateSuccess(operation: 'putPatientsId', data: data));
      },
      onError: (error) {
        emit(PatientsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getPatientsId({required String id}) async {
    emit(PatientsStateLoading());
    final response = await _repo.getPatientsId(id: id);
    response.when(
      onSuccess: (data) {
        emit(PatientsStateSuccess(operation: 'getPatientsId', data: data));
      },
      onError: (error) {
        emit(PatientsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getPatientsIdDetails({required String id}) async {
    emit(PatientsStateLoading());
    final response = await _repo.getPatientsIdDetails(id: id);
    response.when(
      onSuccess: (data) {
        emit(PatientsStateSuccess(operation: 'getPatientsIdDetails', data: data));
      },
      onError: (error) {
        emit(PatientsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getPatientsIdAdmissions({required String id}) async {
    emit(PatientsStateLoading());
    final response = await _repo.getPatientsIdAdmissions(id: id);
    response.when(
      onSuccess: (data) {
        emit(PatientsStateSuccess(operation: 'getPatientsIdAdmissions', data: data));
      },
      onError: (error) {
        emit(PatientsStateError(message: error.messages.first));
      },
    );
  }

}
