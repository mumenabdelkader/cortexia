import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/authentication/data/models/login_request_model.dart';
import 'package:cortexia/features/authentication/data/models/login_response_model.dart';

part 'auth_service.g.dart';
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequest);
}