import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/features/vital_signs/data/models/record_vitals_command_model.dart';
import 'package:cortexia/features/vital_signs/domain/repo/repo_interface.dart';
import '../apis/vital_signs_service.dart';

class VitalSignsRepoImp implements VitalSignsRepoInterface {
  final VitalSignsService _apiService;
  VitalSignsRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidVitals({required String admissionid, required RecordVitalsCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidVitals(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidVitals({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidVitals(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidVitals({required String admissionid, required RecordVitalsCommandModel requestBody}) async {
    try {
      final response = await _apiService.putAdmissionsAdmissionidVitals(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidVitals({required String admissionid, required String id}) async {
    try {
      final response = await _apiService.deleteAdmissionsAdmissionidVitals(admissionid: admissionid, id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
