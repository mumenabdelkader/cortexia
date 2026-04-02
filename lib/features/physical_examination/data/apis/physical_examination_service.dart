import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/features/physical_examination/data/models/add_physical_examination_command_model.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'physical_examination_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PhysicalExaminationService {
  factory PhysicalExaminationService(Dio dio, {String baseUrl}) = _PhysicalExaminationService;

  @POST(ApiConstants.physicalExamination)
  Future<dynamic> postAdmissionsAdmissionidPhysicalExamination({@Path('admissionId') required String admissionid, @Body() required AddPhysicalExaminationCommandModel requestBody});

  @GET(ApiConstants.physicalExamination)
  Future<dynamic> getAdmissionsAdmissionidPhysicalExamination({@Path('admissionId') required String admissionid});

  @PUT(ApiConstants.physicalExamination)
  Future<dynamic> putAdmissionsAdmissionidPhysicalExamination({@Path('admissionId') required String admissionid, @Body() required AddPhysicalExaminationCommandModel requestBody});

  @DELETE(ApiConstants.physicalExamination)
  Future<dynamic> deleteAdmissionsAdmissionidPhysicalExamination({@Path('admissionId') required String admissionid, @Query('Id') required String id});

}
