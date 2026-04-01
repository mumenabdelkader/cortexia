import 'package:cortexia/features/physical_examination/data/models/add_physical_examination_command_model.dart';
import 'package:cortexia/core/networking/api_result.dart';

abstract class PhysicalExaminationRepoInterface {
  Future<ApiResult<dynamic>> postAdmissionsAdmissionidPhysicalExamination({required String admissionid, required AddPhysicalExaminationCommandModel requestBody});
  Future<ApiResult<dynamic>> getAdmissionsAdmissionidPhysicalExamination({required String admissionid});
  Future<ApiResult<dynamic>> putAdmissionsAdmissionidPhysicalExamination({required String admissionid, required AddPhysicalExaminationCommandModel requestBody});
  Future<ApiResult<dynamic>> deleteAdmissionsAdmissionidPhysicalExamination({required String admissionid, required String id});
}
