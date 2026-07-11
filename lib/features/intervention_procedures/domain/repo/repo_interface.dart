import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/intervention_procedures/data/models/add_intervention_procedure_command_model.dart';
import 'package:cortexia/features/intervention_procedures/data/models/intervention_procedure_model.dart';

abstract class InterventionProceduresRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidInterventionProcedures({required String admissionid, required AddInterventionProcedureCommandModel requestBody});
  Future<ApiResult<List<InterventionProcedureModel>>> getAdmissionsAdmissionidInterventionProcedures({required String admissionid});
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidInterventionProcedures({required String admissionid, required AddInterventionProcedureCommandModel requestBody});
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidInterventionProcedures({required String admissionid, required String id});
}
