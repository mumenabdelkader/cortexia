import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/vital_signs/data/models/record_vitals_command_model.dart';

abstract class VitalSignsRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidVitals({required String admissionid, required RecordVitalsCommandModel requestBody});
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidVitals({required String admissionid});
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidVitals({required String admissionid, required RecordVitalsCommandModel requestBody});
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidVitals({required String admissionid, required String id});
}
