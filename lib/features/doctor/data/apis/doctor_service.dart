import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';

part 'doctor_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class DoctorService {
  factory DoctorService(Dio dio, {String baseUrl}) = _DoctorService;

  @GET(ApiConstants.doctorDetails)
  Future<dynamic> getDoctorDetails(@Path('email') String email);
}
