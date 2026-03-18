import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/authentication/data/models/login_request_model.dart';
import 'package:cortexia/features/authentication/data/models/login_response_model.dart';
import 'package:cortexia/features/authentication/data/models/forgot_password_request_body.dart';
import 'package:cortexia/features/authentication/data/models/forgot_password_response_body.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import '../apis/auth_service.dart';

class AuthRepositoryImp implements AuthRepoInterface {
  final AuthService _authService;

  AuthRepositoryImp(this._authService);

  @override
  Future<ApiResult<LoginResponseModel>> login(
      LoginRequestModel loginRequest) async {
    try {
      final response = await _authService.login(loginRequest);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<ForgotPasswordResponseBody>> forgotPassword(
      ForgotPasswordRequestBody forgotPasswordRequest) async {
    try {
      final response = await _authService.forgotPassword(forgotPasswordRequest);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}