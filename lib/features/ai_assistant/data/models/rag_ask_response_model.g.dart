// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rag_ask_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RagAskResponseModel _$RagAskResponseModelFromJson(Map<String, dynamic> json) =>
    RagAskResponseModel(
      id: json['id'] as String?,
      queryText: json['queryText'] as String?,
      scoreTrust: (json['scoreTrust'] as num?)?.toDouble(),
      relevanceLevel: (json['relevanceLevel'] as num?)?.toInt(),
      queryDateTime: json['queryDateTime'] as String?,
      generatedResponse: json['generatedResponse'] as String?,
      doctorId: json['doctorId'] as String?,
      patientId: json['patientId'] as String?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RagAskResponseModelToJson(
  RagAskResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'queryText': instance.queryText,
  'scoreTrust': instance.scoreTrust,
  'relevanceLevel': instance.relevanceLevel,
  'queryDateTime': instance.queryDateTime,
  'generatedResponse': instance.generatedResponse,
  'doctorId': instance.doctorId,
  'patientId': instance.patientId,
  'sources': instance.sources,
};
