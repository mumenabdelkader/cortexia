import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/features/ai_assistant/data/apis/ai_assistant_service.dart';
import 'package:cortexia/features/ai_assistant/data/models/ai_assistant_request_body.dart';
import 'package:cortexia/features/ai_assistant/data/models/rag_ask_response_model.dart';
import 'package:cortexia/features/ai_assistant/domain/repo/ai_assistant_repo_interface.dart';

class AiAssistantRepoImp implements AiAssistantRepoInterface {
  final AiAssistantService _apiService;
  
  AiAssistantRepoImp(this._apiService);

  @override
  Future<ApiResult<RagAskResponseModel>> askRag({
    required String projectId,
    required String admissionId,
    required AiAssistantRequestBody requestBody,
  }) async {
    try {
      final response = await _apiService.askRag(projectId, admissionId, requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
