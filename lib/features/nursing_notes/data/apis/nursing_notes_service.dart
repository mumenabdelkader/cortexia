import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/features/nursing_notes/data/models/add_nursing_note_command_model.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'nursing_notes_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NursingNotesService {
  factory NursingNotesService(Dio dio, {String baseUrl}) = _NursingNotesService;

  @POST(ApiConstants.nursingNotes)
  Future<dynamic> postAdmissionsAdmissionidNursingNotes({@Path('admissionId') required String admissionid, @Body() required AddNursingNoteCommandModel requestBody});

  @GET(ApiConstants.nursingNotes)
  Future<dynamic> getAdmissionsAdmissionidNursingNotes({@Path('admissionId') required String admissionid});

}
