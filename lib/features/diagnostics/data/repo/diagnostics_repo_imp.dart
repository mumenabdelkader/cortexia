import 'package:cortexia/core/networking/api_result.dart';
import '../apis/diagnostics_service.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/features/diagnostics/domain/repo/repo_interface.dart';
import 'package:cortexia/features/diagnostics/data/models/add_lab_result_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/create_lab_order_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/upload_imaging_command_model.dart';

class DiagnosticsRepoImp implements DiagnosticsRepoInterface {
  final DiagnosticsService _apiService;
  DiagnosticsRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postDiagnosticsLabOrders({required CreateLabOrderCommandModel requestBody}) async {
    try {
      final response = await _apiService.postDiagnosticsLabOrders(requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> postDiagnosticsLabResults({required AddLabResultCommandModel requestBody}) async {
    try {
      final response = await _apiService.postDiagnosticsLabResults(requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> postDiagnosticsImaging({required UploadImagingCommandModel requestBody}) async {
    try {
      final response = await _apiService.postDiagnosticsImaging(requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getDiagnosticsLabOrdersAdmissionid({required String admissionid}) async {
    try {
      final response = await _apiService.getDiagnosticsLabOrdersAdmissionid(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getDiagnosticsLabResultsOrderid({required String orderid}) async {
    try {
      final response = await _apiService.getDiagnosticsLabResultsOrderid(orderid: orderid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getDiagnosticsImagingAdmissionid({required String admissionid}) async {
    try {
      final response = await _apiService.getDiagnosticsImagingAdmissionid(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
