import 'package:bloc/bloc.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
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
      onSuccess: (admissions) {
        emit(AdmissionSuccess(admissions));
      },
      onError: (apiErrorModel) {
        emit(AdmissionError(message: apiErrorModel.messages.first));
      },
    );
  }
}
