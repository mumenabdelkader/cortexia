import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/admission/data/apis/admission_service.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';
import 'package:cortexia/features/admission/data/models/admit_patient_command.dart';
import 'package:cortexia/features/admission/data/models/room_model.dart';
import 'package:cortexia/features/admission/domain/repo/admission_repo_interface.dart';
import 'package:cortexia/features/admission/data/models/active_admission_model.dart';

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
      final rooms = await _admissionService.getRooms();
      return ApiResult.success(rooms);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<ActiveAdmissionModel>>> getActiveAdmissions() async {
    try {
      final response = await _admissionService.getActiveAdmissions();
      // Parse the standard response wrapper if it's a Map
      if (response is Map<String, dynamic> && response['data'] != null) {
        final dataList = response['data'] as List;
        final admissions = dataList
            .map(
              (e) => ActiveAdmissionModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return ApiResult.success(admissions);
      } else if (response is List) {
        // Fallback if it returns the list directly
        final admissions = response
            .map(
              (e) => ActiveAdmissionModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return ApiResult.success(admissions);
      }
      return ApiResult.success([]);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<ActiveAdmissionModel>> getAdmissionById(String id) async {
    try {
      final response = await _admissionService.getAdmissionById(id);
      if (response is Map<String, dynamic> && response['data'] != null) {
        final admission = ActiveAdmissionModel.fromJson(
          response['data'] as Map<String, dynamic>,
        );
        return ApiResult.success(admission);
      } else if (response is Map<String, dynamic>) {
        final admission = ActiveAdmissionModel.fromJson(response);
        return ApiResult.success(admission);
      }
      throw Exception('Failed to parse admission details');
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
