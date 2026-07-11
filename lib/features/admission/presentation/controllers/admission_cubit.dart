import 'package:bloc/bloc.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
import 'package:cortexia/features/admission/data/models/admit_patient_command.dart';
import 'package:cortexia/features/admission/domain/repo/admission_repo_interface.dart';
import 'admission_state.dart';

class AdmissionCubit extends Cubit<AdmissionState> {
  final AdmissionRepoInterface _admissionRepo;

  AdmissionCubit(this._admissionRepo) : super(AdmissionInitial());

  Future<void> createAdmission({
    required String patientId,
    required String doctorId,
    required String admissionDate,
    required String initialDiagnosis,
    required String roomId,
    required String bedId,
  }) async {
    emit(AdmissionLoading());

    final response = await _admissionRepo.createAdmission(
      patientId,
      AdmissionRequestBody(
        patientId: patientId,
        doctorId: doctorId,
        admissionDate: admissionDate,
        initialDiagnosis: initialDiagnosis,
        roomId: roomId,
        bedId: bedId,
      ),
    );

    response.when(
      onSuccess: (admissions) => emit(AdmissionSuccess(admissions)),
      onError: (err) => emit(AdmissionError(message: err.messages.first)),
    );
  }

  Future<void> admitPatient(AdmitPatientCommand command) async {
    emit(AdmissionLoading());
    final response = await _admissionRepo.admitPatient(command);
    response.when(
      onSuccess: (data) => emit(AdmitPatientSuccess(data)),
      onError: (err) => emit(AdmissionError(message: err.messages.first)),
    );
  }

  Future<void> loadRooms() async {
    emit(RoomsLoading());
    final response = await _admissionRepo.getRooms();
    response.when(
      onSuccess: (rooms) => emit(RoomsLoaded(rooms)),
      onError: (err) => emit(AdmissionError(message: err.messages.first)),
    );
  }

  Future<void> getActiveAdmissions() async {
    emit(AdmissionLoading());
    final response = await _admissionRepo.getActiveAdmissions();
    response.when(
      onSuccess: (admissions) => emit(ActiveAdmissionsLoaded(admissions)),
      onError: (err) => emit(AdmissionError(message: err.messages.first)),
    );
  }

  Future<void> getAdmissionById(String id) async {
    emit(AdmissionLoading());
    final response = await _admissionRepo.getAdmissionById(id);
    response.when(
      onSuccess: (admission) => emit(AdmissionDetailsLoaded(admission)),
      onError: (err) => emit(AdmissionError(message: err.messages.isNotEmpty ? err.messages.join(', ') : 'Failed to load admission details')),
    );
  }
}
