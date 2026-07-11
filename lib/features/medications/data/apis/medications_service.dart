import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';
import 'package:cortexia/features/medications/data/models/medication_response_model.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_response_model.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'medications_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MedicationsService {
  factory MedicationsService(Dio dio, {String baseUrl}) = _MedicationsService;

  @POST(ApiConstants.admissionMedications)
  Future<PrescribeMedicationResponseModel> postAdmissionsAdmissionidMedications({@Path('admissionId') required String admissionid, @Body() required PrescribeMedicationCommandModel requestBody});

  @GET(ApiConstants.admissionMedications)
  Future<List<MedicationResponseModel>> getAdmissionsAdmissionidMedications({@Path('admissionId') required String admissionid});

  @PUT(ApiConstants.admissionMedications)
  Future<dynamic> putAdmissionsAdmissionidMedications({@Path('admissionId') required String admissionid, @Body() required PrescribeMedicationCommandModel requestBody});

  @DELETE(ApiConstants.admissionMedications)
  Future<dynamic> deleteAdmissionsAdmissionidMedications({@Path('admissionId') required String admissionid, @Query('Id') required String id});

}
