import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/fluid_balance/domain/repo/repo_interface.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import '../apis/fluid_balance_service.dart';
import 'package:cortexia/features/fluid_balance/data/models/add_fluid_balance_command_model.dart';

class FluidBalanceRepoImp implements FluidBalanceRepoInterface {
  final FluidBalanceService _apiService;
  FluidBalanceRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidFluidBalance({required String admissionid, required AddFluidBalanceCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidFluidBalance(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidFluidBalance({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidFluidBalance(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidFluidBalance({required String admissionid, required AddFluidBalanceCommandModel requestBody}) async {
    try {
      final response = await _apiService.putAdmissionsAdmissionidFluidBalance(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidFluidBalance({required String admissionid, required String id}) async {
    try {
      final response = await _apiService.deleteAdmissionsAdmissionidFluidBalance(admissionid: admissionid, id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
