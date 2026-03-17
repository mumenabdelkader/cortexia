import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/patients/data/models/update_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/create_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/get_all_patients_query_model.dart';

part 'patients_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PatientsService {
  factory PatientsService(Dio dio, {String baseUrl}) = _PatientsService;

  @POST(ApiConstants.patients)
  Future<dynamic> postPatients({@Body() required CreatePatientCommandModel requestBody});

  @GET(ApiConstants.patients)
  Future<dynamic> getPatients({@Queries() required GetAllPatientsQueryModel query});

  @PUT(ApiConstants.patientById)
  Future<dynamic> putPatientsId({@Path('id') required String id, @Body() required UpdatePatientCommandModel requestBody});

  @GET(ApiConstants.patientById)
  Future<dynamic> getPatientsId({@Path('id') required String id});

  @GET(ApiConstants.patientDetails)
  Future<dynamic> getPatientsIdDetails({@Path('id') required String id});

  @GET(ApiConstants.patientAdmissions)
  Future<dynamic> getPatientsIdAdmissions({@Path('id') required String id});

}
