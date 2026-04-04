import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';
import 'package:cortexia/features/admission/data/models/admit_patient_command.dart';

part 'admission_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AdmissionService {
  factory AdmissionService(Dio dio, {String baseUrl}) = _AdmissionService;

  @POST(ApiConstants.createAdmission)
  Future<List<AdmissionResponseBody>> createAdmission(
    @Path("patientId") String patientId,
    @Body() AdmissionRequestBody requestBody,
  );

  @POST(ApiConstants.admitPatient)
  Future<dynamic> admitPatient(@Body() AdmitPatientCommand requestBody);

  @GET(ApiConstants.rooms)
  Future<List<dynamic>> getRooms();
}
