import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/authentication/data/models/login_request_model.dart';
import 'package:cortexia/features/authentication/data/models/login_response_model.dart';
import 'package:cortexia/features/authentication/data/models/forgot_password_request_body.dart';
import 'package:cortexia/features/authentication/data/models/forgot_password_response_body.dart';
import 'package:cortexia/features/authentication/data/models/reset_password_request_body.dart';
import 'package:cortexia/features/authentication/data/models/reset_password_response_body.dart';

part 'auth_service.g.dart';
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequest);

  @POST(ApiConstants.forgotPassword)
  Future<ForgotPasswordResponseBody> forgotPassword(
      @Body() ForgotPasswordRequestBody forgotPasswordRequestBody);

  @POST(ApiConstants.resetPassword)
  Future<ResetPasswordResponseBody> resetPassword(
      @Body() ResetPasswordRequestBody resetPasswordRequestBody);
}