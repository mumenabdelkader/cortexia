import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/features/vital_signs/data/models/record_vitals_command_model.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'vital_signs_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class VitalSignsService {
  factory VitalSignsService(Dio dio, {String baseUrl}) = _VitalSignsService;

  @POST(ApiConstants.vitalSigns)
  Future<dynamic> postAdmissionsAdmissionidVitals({@Path('admissionId') required String admissionid, @Body() required RecordVitalsCommandModel requestBody});

  @GET(ApiConstants.vitalSigns)
  Future<dynamic> getAdmissionsAdmissionidVitals({@Path('admissionId') required String admissionid});

  @PUT(ApiConstants.vitalSigns)
  Future<dynamic> putAdmissionsAdmissionidVitals({@Path('admissionId') required String admissionid, @Body() required RecordVitalsCommandModel requestBody});

  @DELETE(ApiConstants.vitalSigns)
  Future<dynamic> deleteAdmissionsAdmissionidVitals({@Path('admissionId') required String admissionid, @Query('Id') required String id});

}
