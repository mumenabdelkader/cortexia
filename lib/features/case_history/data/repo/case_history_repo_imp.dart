import 'package:cortexia/core/networking/api_result.dart';
import '../apis/case_history_service.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_command_model.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_response_model.dart';
import 'package:cortexia/features/case_history/data/models/case_history_model.dart';
import 'package:cortexia/features/case_history/domain/repo/repo_interface.dart';

class CaseHistoryRepoImp implements CaseHistoryRepoInterface {
  final CaseHistoryService _apiService;
  CaseHistoryRepoImp(this._apiService);

  @override
  Future<ApiResult<AddCaseHistoryResponseModel>> postAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidCaseHistory(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<CaseHistoryModel>>> getAdmissionsAdmissionidCaseHistory({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidCaseHistory(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody}) async {
    try {
      final response = await _apiService.putAdmissionsAdmissionidCaseHistory(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidCaseHistory({required String admissionid, required String id}) async {
    try {
      final response = await _apiService.deleteAdmissionsAdmissionidCaseHistory(admissionid: admissionid, id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
