import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/diagnostics/data/models/add_lab_result_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/create_lab_order_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/upload_imaging_command_model.dart';

part 'diagnostics_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DiagnosticsService {
  factory DiagnosticsService(Dio dio, {String baseUrl}) = _DiagnosticsService;

  @POST(ApiConstants.diagnosticsLabOrders)
  Future<dynamic> postDiagnosticsLabOrders({@Body() required CreateLabOrderCommandModel requestBody});

  @POST(ApiConstants.diagnosticsLabResults)
  Future<dynamic> postDiagnosticsLabResults({@Body() required AddLabResultCommandModel requestBody});

  @POST(ApiConstants.diagnosticsImaging)
  Future<dynamic> postDiagnosticsImaging({@Body() required UploadImagingCommandModel requestBody});

  @GET(ApiConstants.diagnosticsLabOrdersByAdmission)
  Future<dynamic> getDiagnosticsLabOrdersAdmissionid({@Path('admissionId') required String admissionid});

  @GET(ApiConstants.diagnosticsLabResultsByOrder)
  Future<dynamic> getDiagnosticsLabResultsOrderid({@Path('orderId') required String orderid});

  @GET(ApiConstants.diagnosticsImagingByAdmission)
  Future<dynamic> getDiagnosticsImagingAdmissionid({@Path('admissionId') required String admissionid});

}
