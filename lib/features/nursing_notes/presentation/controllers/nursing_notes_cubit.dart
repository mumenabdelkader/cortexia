import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cortexia/features/nursing_notes/domain/repo/repo_interface.dart';
import 'package:cortexia/features/nursing_notes/data/models/add_nursing_note_command_model.dart';

part 'nursing_notes_state.dart';

class NursingNotesCubit extends Cubit<NursingNotesState> {
  final NursingNotesRepoInterface _repo;

  NursingNotesCubit(this._repo) : super(NursingNotesStateInitial());

  Future<void> postAdmissionsAdmissionidNursingNotes({required String admissionid, required AddNursingNoteCommandModel requestBody}) async {
    emit(NursingNotesStateLoading());
    final response = await _repo.postAdmissionsAdmissionidNursingNotes(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(NursingNotesStateSuccess(operation: 'post', data: data));
      },
      onError: (error) {
        emit(NursingNotesStateError(message: error.messages.first));
      },
    );
  }

  Future<void> getAdmissionsAdmissionidNursingNotes({required String admissionid}) async {
    emit(NursingNotesStateLoading());
    final response = await _repo.getAdmissionsAdmissionidNursingNotes(admissionid: admissionid);
    response.when(
      onSuccess: (data) {
        emit(NursingNotesStateSuccess(operation: 'get', data: data));
      },
      onError: (error) {
        emit(NursingNotesStateError(message: error.messages.first));
      },
    );
  }

  Future<void> putAdmissionsAdmissionidNursingNotes({required String admissionid, required AddNursingNoteCommandModel requestBody}) async {
    emit(NursingNotesStateLoading());
    final response = await _repo.putAdmissionsAdmissionidNursingNotes(admissionid: admissionid, requestBody: requestBody);
    response.when(
      onSuccess: (data) {
        emit(NursingNotesStateSuccess(operation: 'put', data: data));
      },
      onError: (error) {
        emit(NursingNotesStateError(message: error.messages.first));
      },
    );
  }

  Future<void> deleteAdmissionsAdmissionidNursingNotes({required String admissionid, required String id}) async {
    emit(NursingNotesStateLoading());
    final response = await _repo.deleteAdmissionsAdmissionidNursingNotes(admissionid: admissionid, id: id);
    response.when(
      onSuccess: (data) {
        emit(NursingNotesStateSuccess(operation: 'delete', data: data));
      },
      onError: (error) {
        emit(NursingNotesStateError(message: error.messages.first));
      },
    );
  }

}
