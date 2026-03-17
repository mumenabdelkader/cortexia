import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/diagnostics/data/models/add_lab_result_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/create_lab_order_command_model.dart';
import 'package:cortexia/features/diagnostics/data/models/upload_imaging_command_model.dart';

abstract class DiagnosticsRepoInterface {
  Future<ApiResult<dynamic>> postDiagnosticsLabOrders({required CreateLabOrderCommandModel requestBody});
  Future<ApiResult<dynamic>> postDiagnosticsLabResults({required AddLabResultCommandModel requestBody});
  Future<ApiResult<dynamic>> postDiagnosticsImaging({required UploadImagingCommandModel requestBody});
  Future<ApiResult<dynamic>> getDiagnosticsLabOrdersAdmissionid({required String admissionid});
  Future<ApiResult<dynamic>> getDiagnosticsLabResultsOrderid({required String orderid});
  Future<ApiResult<dynamic>> getDiagnosticsImagingAdmissionid({required String admissionid});
}
