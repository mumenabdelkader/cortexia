// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_assistant_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiAssistantRequestBody _$AiAssistantRequestBodyFromJson(
  Map<String, dynamic> json,
) => AiAssistantRequestBody(
  text: json['text'] as String,
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$AiAssistantRequestBodyToJson(
  AiAssistantRequestBody instance,
) => <String, dynamic>{'text': instance.text, 'limit': instance.limit};
