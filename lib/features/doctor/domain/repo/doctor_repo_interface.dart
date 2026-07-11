import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';

abstract class DoctorRepoInterface {
  Future<ApiResult<DoctorModel>> getDoctorDetails(String email);
}
