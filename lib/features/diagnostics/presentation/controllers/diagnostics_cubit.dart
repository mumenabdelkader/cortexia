import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/diagnostics/domain/repo/repo_interface.dart';
import 'package:cortexia/features/diagnostics/data/models/create_lab_order_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/add_lab_result_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/upload_imaging_command_model.dart';

part 'diagnostics_state.dart';

class DiagnosticsCubit extends Cubit<DiagnosticsState> {
  final DiagnosticsRepoInterface _repo;

  DiagnosticsCubit(this._repo) : super(DiagnosticsStateInitial());

  Future<void> postDiagnosticsLabOrders({required CreateLabOrderCommandModel requestBody}) async {
    emit(DiagnosticsStateLoading());
    final response = await _repo.postDiagnosticsLabOrders(requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(DiagnosticsStateSuccess(operation: 'postDiagnosticsLabOrders', data: data));
      },
      onError: (error) {
        emit(DiagnosticsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> postDiagnosticsLabResults({required AddLabResultCommandModel requestBody}) async {
    emit(DiagnosticsStateLoading());
    final response = await _repo.postDiagnosticsLabResults(requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(DiagnosticsStateSuccess(operation: 'postDiagnosticsLabResults', data: data));
      },
      onError: (error) {
        emit(DiagnosticsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> postDiagnosticsImaging({required UploadImagingCommandModel requestBody}) async {
    emit(DiagnosticsStateLoading());
    final response = await _repo.postDiagnosticsImaging(requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(DiagnosticsStateSuccess(operation: 'postDiagnosticsImaging', data: data));
      },
      onError: (error) {
        emit(DiagnosticsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getDiagnosticsLabOrdersAdmissionid({required String admissionid}) async {
    emit(DiagnosticsStateLoading());
    final response = await _repo.getDiagnosticsLabOrdersAdmissionid(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(DiagnosticsStateSuccess(operation: 'getDiagnosticsLabOrdersAdmissionid', data: data));
      },
      onError: (error) {
        emit(DiagnosticsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getDiagnosticsLabResultsOrderid({required String orderid}) async {
    emit(DiagnosticsStateLoading());
    final response = await _repo.getDiagnosticsLabResultsOrderid(orderid: orderid);
    response.when(
      onSuccess: (data) {
        emit(DiagnosticsStateSuccess(operation: 'getDiagnosticsLabResultsOrderid', data: data));
      },
      onError: (error) {
        emit(DiagnosticsStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getDiagnosticsImagingAdmissionid({required String admissionid}) async {
    emit(DiagnosticsStateLoading());
    final response = await _repo.getDiagnosticsImagingAdmissionid(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(DiagnosticsStateSuccess(operation: 'getDiagnosticsImagingAdmissionid', data: data));
      },
      onError: (error) {
        emit(DiagnosticsStateError(message: error.messages.first));
      },
    );
  }

}
