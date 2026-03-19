import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';

abstract class AdmissionRepoInterface {
  Future<ApiResult<List<AdmissionResponseBody>>> createAdmission(
    String patientId,
    AdmissionRequestBody requestBody,
  );
}
