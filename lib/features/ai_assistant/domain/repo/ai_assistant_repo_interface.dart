import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/ai_assistant/data/models/ai_assistant_request_body.dart';
import 'package:cortexia/features/ai_assistant/data/models/rag_ask_response_model.dart';

abstract class AiAssistantRepoInterface {
  Future<ApiResult<RagAskResponseModel>> askRag({
    required String projectId,
    required String admissionId,
    required AiAssistantRequestBody requestBody,
  });
}
