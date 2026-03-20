import 'package:dio/dio.dart' hide Headers;
import 'package:cortexia/features/case_history/data/models/add_case_history_command_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'case_history_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CaseHistoryService {
  factory CaseHistoryService(Dio dio, {String baseUrl}) = _CaseHistoryService;

  @POST(ApiConstants.caseHistory)
  Future<dynamic> postAdmissionsAdmissionidCaseHistory({@Path('admissionId') required String admissionid, @Body() required AddCaseHistoryCommandModel requestBody});

  @GET(ApiConstants.caseHistory)
  Future<dynamic> getAdmissionsAdmissionidCaseHistory({@Path('admissionId') required String admissionid});

}
