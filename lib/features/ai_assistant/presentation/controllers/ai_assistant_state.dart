part of 'ai_assistant_cubit.dart';

@immutable
abstract class AiAssistantState {}

class AiAssistantStateInitial extends AiAssistantState {}

class AiAssistantStateLoading extends AiAssistantState {}

class AiAssistantStateSuccess extends AiAssistantState {
  final RagAskResponseModel data;

  AiAssistantStateSuccess({required this.data});
}

class AiAssistantStateError extends AiAssistantState {
  final String message;

  AiAssistantStateError({required this.message});
}
