import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';
import 'package:cortexia/features/medications/data/models/medication_response_model.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_response_model.dart';

abstract class MedicationsRepoInterface {
  Future<ApiResult<PrescribeMedicationResponseModel>> postAdmissionsAdmissionidMedications({required String admissionid, required PrescribeMedicationCommandModel requestBody});
  Future<ApiResult<List<MedicationResponseModel>>> getAdmissionsAdmissionidMedications({required String admissionid});
}
