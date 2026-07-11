import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/features/patients/domain/repo/repo_interface.dart';
import 'package:cortexia/features/patients/data/models/update_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/create_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/get_all_patients_query_model.dart';
import 'package:cortexia/features/patients/data/models/patient_details_response_model.dart';
import '../apis/patients_service.dart';

class PatientsRepoImp implements PatientsRepoInterface {
  final PatientsService _apiService;
  PatientsRepoImp(this._apiService);

  @override
  Future<ApiResult<dynamic>> postPatients({required CreatePatientCommandModel requestBody}) async {
    try {
      final response = await _apiService.postPatients(requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getPatients({required GetAllPatientsQueryModel query}) async {
    try {
      final response = await _apiService.getPatients(query: query);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> putPatientsId({required String id, required UpdatePatientCommandModel requestBody}) async {
    try {
      final response = await _apiService.putPatientsId(id: id, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getPatientsId({required String id}) async {
    try {
      final response = await _apiService.getPatientsId(id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<PatientDetailsResponseModel>> getPatientsIdDetails({required String id}) async {
    try {
      final response = await _apiService.getPatientsIdDetails(id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<dynamic>> getPatientsIdAdmissions({required String id}) async {
    try {
      final response = await _apiService.getPatientsIdAdmissions(id: id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
