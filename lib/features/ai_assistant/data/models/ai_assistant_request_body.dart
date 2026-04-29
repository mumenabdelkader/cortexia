import 'package:json_annotation/json_annotation.dart';

part 'ai_assistant_request_body.g.dart';

@JsonSerializable()
class AiAssistantRequestBody {
  final String text;
  final int limit;

  AiAssistantRequestBody({
    required this.text,
    required this.limit,
  });

  factory AiAssistantRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AiAssistantRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AiAssistantRequestBodyToJson(this);
}
