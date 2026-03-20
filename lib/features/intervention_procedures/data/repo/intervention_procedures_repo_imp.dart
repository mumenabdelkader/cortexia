import 'package:cortexia/features/intervention_procedures/domain/repo/repo_interface.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/intervention_procedures/data/models/add_intervention_procedure_command_model.dart';
import '../apis/intervention_procedures_service.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';

class InterventionProceduresRepoImp implements InterventionProceduresRepoInterface {
  final InterventionProceduresService _apiService;
  InterventionProceduresRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidInterventionProcedures({required String admissionid, required AddInterventionProcedureCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidInterventionProcedures(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidInterventionProcedures({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidInterventionProcedures(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
