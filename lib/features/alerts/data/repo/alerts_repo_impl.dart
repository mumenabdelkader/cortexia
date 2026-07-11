import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/alerts/data/apis/alerts_service.dart';
import 'package:cortexia/features/alerts/data/models/alert_model.dart';
import 'package:cortexia/features/alerts/data/models/override_alert_request.dart';
import 'package:cortexia/features/alerts/domain/repo/alerts_repo_interface.dart';

class AlertsRepoImpl implements AlertsRepoInterface {
  final AlertsService _apiService;

  AlertsRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<AlertModel>>> getActiveAlerts(String? admissionId) async {
    try {
      final response = await _apiService.getActiveAlerts(admissionId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(error);
    }
  }

  @override
  Future<ApiResult<dynamic>> overrideAlert(String id, OverrideAlertRequest request) async {
    try {
      final response = await _apiService.overrideAlert(id, request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(error);
    }
  }
}
