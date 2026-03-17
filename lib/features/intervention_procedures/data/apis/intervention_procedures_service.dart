import 'package:dio/dio.dart' hide Headers;
import 'package:cortexia/features/intervention_procedures/data/models/add_intervention_procedure_command_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'intervention_procedures_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class InterventionProceduresService {
  factory InterventionProceduresService(Dio dio, {String baseUrl}) = _InterventionProceduresService;

  @POST(ApiConstants.interventionProcedures)
  Future<dynamic> postAdmissionsAdmissionidInterventionProcedures({@Path('admissionId') required String admissionid, @Body() required AddInterventionProcedureCommandModel requestBody});

  @GET(ApiConstants.interventionProcedures)
  Future<dynamic> getAdmissionsAdmissionidInterventionProcedures({@Path('admissionId') required String admissionid});

}
