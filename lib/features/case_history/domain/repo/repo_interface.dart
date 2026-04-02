import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_command_model.dart';
import 'package:cortexia/features/case_history/data/models/add_case_history_response_model.dart';
import 'package:cortexia/features/case_history/data/models/case_history_model.dart';

abstract class CaseHistoryRepoInterface {
  Future<ApiResult<AddCaseHistoryResponseModel>> postAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody});
  Future<ApiResult<List<CaseHistoryModel>>> getAdmissionsAdmissionidCaseHistory({required String admissionid});
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidCaseHistory({required String admissionid, required AddCaseHistoryCommandModel requestBody});
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidCaseHistory({required String admissionid, required String id});
}
