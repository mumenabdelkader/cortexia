import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import '../apis/medications_service.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_command_model.dart';
import 'package:cortexia/features/medications/data/models/medication_response_model.dart';
import 'package:cortexia/features/medications/data/models/prescribe_medication_response_model.dart';
import 'package:cortexia/features/medications/domain/repo/repo_interface.dart';

class MedicationsRepoImp implements MedicationsRepoInterface {
  final MedicationsService _apiService;
  MedicationsRepoImp(this._apiService);

  @override
  Future<ApiResult<PrescribeMedicationResponseModel>> postAdmissionsAdmissionidMedications({required String admissionid, required PrescribeMedicationCommandModel requestBody}) async {
    try {
      final response = await _apiService.postAdmissionsAdmissionidMedications(admissionid: admissionid, requestBody: requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<MedicationResponseModel>>> getAdmissionsAdmissionidMedications({required String admissionid}) async {
    try {
      final response = await _apiService.getAdmissionsAdmissionidMedications(admissionid: admissionid);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

}
