import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/case_history/domain/repo/repo_interface.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_command_model.dart';

part 'case_history_state.dart';

class CaseHistoryCubit extends Cubit<CaseHistoryState> {
  final CaseHistoryRepoInterface _repo;

  CaseHistoryCubit(this._repo) : super(CaseHistoryStateInitial());

  Future<void> postAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody}) async {
    emit(CaseHistoryStateLoading());
    final response = await _repo.postAdmissionsAdmissionidCaseHistory(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(CaseHistoryStateSuccess(operation: 'post', data: data));
        getAdmissionsAdmissionidCaseHistory(admissionid: admissionid);
      },
      onError: (error) {
        emit(CaseHistoryStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidCaseHistory({required String admissionid}) async {
    emit(CaseHistoryStateLoading());
    final response = await _repo.getAdmissionsAdmissionidCaseHistory(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(CaseHistoryStateSuccess(operation: 'get', data: data));
      },
      onError: (error) {
        emit(CaseHistoryStateError(message: error.messages.first));
      },
    );
  }

  Future<void> putAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody}) async {
    emit(CaseHistoryStateLoading());
    final response = await _repo.putAdmissionsAdmissionidCaseHistory(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(CaseHistoryStateSuccess(operation: 'put', data: data));
      },
      onError: (error) {
        emit(CaseHistoryStateError(message: error.messages.first));
      },
    );
  }

  Future<void> deleteAdmissionsAdmissionidCaseHistory({required String admissionid, required String id}) async {
    emit(CaseHistoryStateLoading());
    final response = await _repo.deleteAdmissionsAdmissionidCaseHistory(admissionid: admissionid, id: id);
    response.when(
      onSuccess: (data) {
        emit(CaseHistoryStateSuccess(operation: 'delete', data: data));
      },
      onError: (error) {
        emit(CaseHistoryStateError(message: error.messages.first));
      },
    );
  }

}
