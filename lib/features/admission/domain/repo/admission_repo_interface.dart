import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/admission/data/models/admission_request_body.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';
import 'package:cortexia/features/admission/data/models/admit_patient_command.dart';
import 'package:cortexia/features/admission/data/models/room_model.dart';
import 'package:cortexia/features/admission/data/models/active_admission_model.dart';

abstract class AdmissionRepoInterface {
  Future<ApiResult<List<AdmissionResponseBody>>> createAdmission(
    String patientId,
    AdmissionRequestBody requestBody,
  );

  Future<ApiResult<dynamic>> admitPatient(AdmitPatientCommand command);

  Future<ApiResult<List<RoomModel>>> getRooms();

  Future<ApiResult<List<ActiveAdmissionModel>>> getActiveAdmissions();

  Future<ApiResult<ActiveAdmissionModel>> getAdmissionById(String id);
}
