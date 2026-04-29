import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/ai_assistant/data/models/ai_assistant_request_body.dart';
import 'package:cortexia/features/ai_assistant/data/models/rag_ask_response_model.dart';

part 'ai_assistant_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AiAssistantService {
  factory AiAssistantService(Dio dio, {String baseUrl}) = _AiAssistantService;

  @POST(ApiConstants.askSmartAssistantRag)
  Future<RagAskResponseModel> askRag(
    @Query("projectId") String projectId,
    @Query("admissionId") String admissionId,
    @Body() AiAssistantRequestBody requestBody,
  );
}
