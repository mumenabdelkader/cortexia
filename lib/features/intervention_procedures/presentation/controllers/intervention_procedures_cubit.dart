import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/intervention_procedures/domain/repo/repo_interface.dart';
import 'package:cortexia/features/intervention_procedures/data/models/add_intervention_procedure_command_model.dart';

part 'intervention_procedures_state.dart';

class InterventionProceduresCubit extends Cubit<InterventionProceduresState> {
  final InterventionProceduresRepoInterface _repo;

  InterventionProceduresCubit(this._repo)
    : super(InterventionProceduresStateInitial());

  Future<void> postAdmissionsAdmissionidInterventionProcedures({
    required String admissionid,
    required AddInterventionProcedureCommandModel requestBody,
  }) async {
    emit(InterventionProceduresStateLoading());
    final response = await _repo
        .postAdmissionsAdmissionidInterventionProcedures(
          admissionid: admissionid,
          requestBody: requestBody,
        );
    response.when(
      onSuccess: (data) {
        emit(InterventionProceduresStateSuccess(operation: 'post', data: data));
      },
      onError: (error) {
        emit(InterventionProceduresStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidInterventionProcedures({
    required String admissionid,
  }) async {
    emit(InterventionProceduresStateLoading());
    final response = await _repo.getAdmissionsAdmissionidInterventionProcedures(
      admissionid: admissionid,
    );
    response.when(
      onSuccess: (data) {
        emit(InterventionProceduresStateSuccess(operation: 'get', data: data));
      },
      onError: (error) {
        emit(InterventionProceduresStateError(message: error.messages.first));
      },
    );
  }

  Future<void> putAdmissionsAdmissionidInterventionProcedures({
    required String admissionid,
    required AddInterventionProcedureCommandModel requestBody,
  }) async {
    emit(InterventionProceduresStateLoading());
    final response = await _repo.putAdmissionsAdmissionidInterventionProcedures(
      admissionid: admissionid,
      requestBody: requestBody,
    );
    response.when(
      onSuccess: (data) {
        emit(InterventionProceduresStateSuccess(operation: 'put', data: data));
      },
      onError: (error) {
        emit(InterventionProceduresStateError(message: error.messages.first));
      },
    );
  }

  Future<void> deleteAdmissionsAdmissionidInterventionProcedures({
    required String admissionid,
    required String id,
  }) async {
    emit(InterventionProceduresStateLoading());
    final response = await _repo
        .deleteAdmissionsAdmissionidInterventionProcedures(
          admissionid: admissionid,
          id: id,
        );
    response.when(
      onSuccess: (data) {
        emit(
          InterventionProceduresStateSuccess(operation: 'delete', data: data),
        );
      },
      onError: (error) {
        emit(InterventionProceduresStateError(message: error.messages.first));
      },
    );
  }
}
