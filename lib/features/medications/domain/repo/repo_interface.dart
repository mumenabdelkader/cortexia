import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';

abstract class MedicationsRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidMedications({required String admissionid, required PrescribeMedicationCommandModel requestBody});
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidMedications({required String admissionid});
}
