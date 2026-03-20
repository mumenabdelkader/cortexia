import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_command_model.dart';

abstract class CaseHistoryRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody});
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidCaseHistory({required String admissionid});
}
