import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/alerts/data/models/alert_model.dart';
import 'package:cortexia/features/alerts/data/models/override_alert_request.dart';

abstract class AlertsRepoInterface {
  Future<ApiResult<List<AlertModel>>> getActiveAlerts(String? admissionId);
  Future<ApiResult<dynamic>> overrideAlert(String id, OverrideAlertRequest request);
}
