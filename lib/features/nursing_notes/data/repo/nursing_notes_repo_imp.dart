import 'package:cortexia/core/networking/api_result.dart';
import '../apis/nursing_notes_service.dart';
import 'package:cortexia/features/nursing_notes/data/models/add_nursing_note_command_model.dart';
import 'package:cortexia/features/nursing_notes/domain/repo/repo_interface.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';

class NursingNotesRepoImp implements NursingNotesRepoInterface {
  final NursingNotesService _apiService;
  NursingNotesRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidNursingNotes({required String admissionid, required AddNursingNoteCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidNursingNotes(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidNursingNotes({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidNursingNotes(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidNursingNotes({required String admissionid, required AddNursingNoteCommandModel requestBody}) async {
    try {
      final response = await _apiService.putAdmissionsAdmissionidNursingNotes(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidNursingNotes({required String admissionid, required String id}) async {
    try {
      final response = await _apiService.deleteAdmissionsAdmissionidNursingNotes(admissionid: admissionid, id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
