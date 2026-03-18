import '../../../../core/networking/api_result.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/forgot_password_request_body.dart';
import '../../data/models/forgot_password_response_body.dart';
import '../../data/models/reset_password_request_body.dart';
import '../../data/models/reset_password_response_body.dart';

abstract class AuthRepoInterface {
  Future<ApiResult<LoginResponseModel>> login(
      LoginRequestModel loginRequest,
      );

  Future<ApiResult<ForgotPasswordResponseBody>> forgotPassword(
      ForgotPasswordRequestBody forgotPasswordRequest,
      );

  Future<ApiResult<ResetPasswordResponseBody>> resetPassword(
      ResetPasswordRequestBody resetPasswordRequest,
      );

// تقدر تضيف هنا أي عمليات تانية متعلقة بالـ Auth مستقبلاً
// Future<ApiResult<void>> logout();
// Future<ApiResult<LoginResponseModel>> register(RegisterRequestModel registerRequest);
}