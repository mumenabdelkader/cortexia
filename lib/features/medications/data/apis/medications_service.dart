import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'medications_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MedicationsService {
  factory MedicationsService(Dio dio, {String baseUrl}) = _MedicationsService;

  @POST(ApiConstants.admissionMedications)
  Future<dynamic> postAdmissionsAdmissionidMedications({@Path('admissionId') required String admissionid, @Body() required PrescribeMedicationCommandModel requestBody});

  @GET(ApiConstants.admissionMedications)
  Future<dynamic> getAdmissionsAdmissionidMedications({@Path('admissionId') required String admissionid});

}
