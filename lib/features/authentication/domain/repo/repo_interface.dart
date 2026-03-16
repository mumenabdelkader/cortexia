import '../../../../core/networking/api_result.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';

abstract class AuthRepoInterface {
  Future<ApiResult<LoginResponseModel>> login(
      LoginRequestModel loginRequest,
      );

// تقدر تضيف هنا أي عمليات تانية متعلقة بالـ Auth مستقبلاً
// Future<ApiResult<void>> logout();
// Future<ApiResult<LoginResponseModel>> register(RegisterRequestModel registerRequest);
}