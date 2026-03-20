import 'package:cortexia/features/patients/data/models/update_patient_command_model.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/patients/data/models/create_patient_command_model.dart';
import 'package:cortexia/features/patients/data/models/get_all_patients_query_model.dart';

abstract class PatientsRepoInterface {
  Future<ApiResult<dynamic>> postPatients({required CreatePatientCommandModel requestBody});
  Future<ApiResult<dynamic>> getPatients({required GetAllPatientsQueryModel query});
  Future<ApiResult<dynamic>> putPatientsId({required String id, required UpdatePatientCommandModel requestBody});
  Future<ApiResult<dynamic>> getPatientsId({required String id});
  Future<ApiResult<dynamic>> getPatientsIdDetails({required String id});
  Future<ApiResult<dynamic>> getPatientsIdAdmissions({required String id});
}
