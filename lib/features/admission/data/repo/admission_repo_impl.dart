import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/admission/data/apis/admission_service.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';
import 'package:cortexia/features/admission/data/models/admit_patient_command.dart';
import 'package:cortexia/features/admission/data/models/room_model.dart';
import 'package:cortexia/features/admission/domain/repo/admission_repo_interface.dart';

class AdmissionRepoImpl implements AdmissionRepoInterface {
  final AdmissionService _admissionService;

  AdmissionRepoImpl(this._admissionService);

  @override
  Future<ApiResult<List<AdmissionResponseBody>>> createAdmission(
    String patientId,
    AdmissionRequestBody requestBody,
  ) async {
    try {
      final response = await _admissionService.createAdmission(
        patientId,
        requestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> admitPatient(AdmitPatientCommand command) async {
    try {
      final response = await _admissionService.admitPatient(command);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<RoomModel>>> getRooms() async {
    try {
      final rawList = await _admissionService.getRooms();
      final rooms = rawList
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(rooms);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
