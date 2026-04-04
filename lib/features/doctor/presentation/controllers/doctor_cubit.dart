import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';
import 'package:cortexia/features/doctor/domain/repo/doctor_repo_interface.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepoInterface _repo;

  DoctorCubit(this._repo) : super(DoctorInitial());

  Future<void> loadDoctorDetails(String email) async {
    if (email.isEmpty) {
      emit(DoctorError('No email found. Please log in again.'));
      return;
    }
    emit(DoctorLoading());
    final result = await _repo.getDoctorDetails(email);
    result.when(
      onSuccess: (doctor) => emit(DoctorLoaded(doctor)),
      onError: (err) => emit(DoctorError(err.messages.first)),
    );
  }
}
