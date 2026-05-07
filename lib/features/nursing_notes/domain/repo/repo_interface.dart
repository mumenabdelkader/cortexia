import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/nursing_notes/data/models/add_nursing_note_command_model.dart';
import 'package:cortexia/features/nursing_notes/data/models/nursing_note_model.dart';

abstract class NursingNotesRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidNursingNotes({required String admissionid, required AddNursingNoteCommandModel requestBody});
  Future<ApiResult<List<NursingNoteModel>>> getAdmissionsAdmissionidNursingNotes({required String admissionid});
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidNursingNotes({required String admissionid, required AddNursingNoteCommandModel requestBody});
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidNursingNotes({required String admissionid, required String id});
}
