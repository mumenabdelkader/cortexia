import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/doctor/data/apis/doctor_service.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';
import 'package:cortexia/features/doctor/domain/repo/doctor_repo_interface.dart';

class DoctorRepoImpl implements DoctorRepoInterface {
  final DoctorService _service;

  DoctorRepoImpl(this._service);

  @override
  Future<ApiResult<DoctorModel>> getDoctorDetails(String email) async {
    try {
      final raw = await _service.getDoctorDetails(email);
      final doctor = DoctorModel.fromJson(raw as Map<String, dynamic>);
      return ApiResult.success(doctor);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
