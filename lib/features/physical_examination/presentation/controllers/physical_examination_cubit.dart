import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:cortexia/features/physical_examination/domain/repo/repo_interface.dart';
import 'package:cortexia/features/physical_examination/data/models/add_physical_examination_command_model.dart';

part 'physical_examination_state.dart';

class PhysicalExaminationCubit extends Cubit<PhysicalExaminationState> {
  final PhysicalExaminationRepoInterface _repo;

  PhysicalExaminationCubit(this._repo) : super(PhysicalExaminationStateInitial());

  Future<void> postAdmissionsAdmissionidPhysicalExamination({required String admissionid, required AddPhysicalExaminationCommandModel requestBody}) async {
    emit(PhysicalExaminationStateLoading());
    final response = await _repo.postAdmissionsAdmissionidPhysicalExamination(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(PhysicalExaminationStateSuccess(operation: 'postAdmissionsAdmissionidPhysicalExamination', data: data));
      },
      onError: (error) {
        emit(PhysicalExaminationStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidPhysicalExamination({required String admissionid}) async {
    emit(PhysicalExaminationStateLoading());
    final response = await _repo.getAdmissionsAdmissionidPhysicalExamination(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(PhysicalExaminationStateSuccess(operation: 'getAdmissionsAdmissionidPhysicalExamination', data: data));
      },
      onError: (error) {
        emit(PhysicalExaminationStateError(message: error.messages.first));
      },
    );
  }

}
