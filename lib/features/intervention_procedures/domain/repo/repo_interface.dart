import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/intervention_procedures/data/models/add_intervention_procedure_command_model.dart';

abstract class InterventionProceduresRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidInterventionProcedures({required String admissionid, required AddInterventionProcedureCommandModel requestBody});
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidInterventionProcedures({required String admissionid});
}
