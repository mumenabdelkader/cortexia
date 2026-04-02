import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/features/physical_examination/domain/repo/repo_interface.dart';
import 'package:cortexia/features/physical_examination/data/models/add_physical_examination_command_model.dart';
import '../apis/physical_examination_service.dart';

class PhysicalExaminationRepoImp implements PhysicalExaminationRepoInterface {
  final PhysicalExaminationService _apiService;
  PhysicalExaminationRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidPhysicalExamination({required String admissionid, required AddPhysicalExaminationCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidPhysicalExamination(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidPhysicalExamination({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidPhysicalExamination(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidPhysicalExamination({required String admissionid, required AddPhysicalExaminationCommandModel requestBody}) async {
    try {
      final response = await _apiService.putAdmissionsAdmissionidPhysicalExamination(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidPhysicalExamination({required String admissionid, required String id}) async {
    try {
      final response = await _apiService.deleteAdmissionsAdmissionidPhysicalExamination(admissionid: admissionid, id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
