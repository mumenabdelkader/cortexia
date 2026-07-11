import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/alerts/data/models/alert_model.dart';
import 'package:cortexia/features/alerts/data/models/override_alert_request.dart';

part 'alerts_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AlertsService {
  factory AlertsService(Dio dio, {String baseUrl}) = _AlertsService;

  @GET(ApiConstants.activeAlerts)
  Future<List<AlertModel>> getActiveAlerts(
    @Query('admissionId') String? admissionId,
  );

  @POST('/api/SmartAssistant/alerts/{id}/override')
  Future<dynamic> overrideAlert(
    @Path('id') String id,
    @Body() OverrideAlertRequest request,
  );
}
