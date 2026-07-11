import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/ai_assistant/data/models/ai_assistant_request_body.dart';
import 'package:cortexia/features/ai_assistant/data/models/rag_ask_response_model.dart';
import 'package:cortexia/features/ai_assistant/domain/repo/ai_assistant_repo_interface.dart';

part 'ai_assistant_state.dart';

class AiAssistantCubit extends Cubit<AiAssistantState> {
  final AiAssistantRepoInterface _repo;

  AiAssistantCubit(this._repo) : super(AiAssistantStateInitial());

  Future<void> askRag({
    required String projectId,
    required String admissionId,
    required String text,
    required int limit,
  }) async {
    emit(AiAssistantStateLoading());
    
    final requestBody = AiAssistantRequestBody(text: text, limit: limit);
    
    final result = await _repo.askRag(
      projectId: projectId,
      admissionId: admissionId,
      requestBody: requestBody,
    );

    result.when(
      onSuccess: (data) {
        emit(AiAssistantStateSuccess(data: data));
      },
      onError: (error) {
        emit(AiAssistantStateError(message: error.messages.isNotEmpty ? error.messages.first : 'Unknown error occurred'));
      },
    );
  }
}
