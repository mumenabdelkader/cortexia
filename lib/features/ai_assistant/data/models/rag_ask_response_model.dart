import 'package:json_annotation/json_annotation.dart';

part 'rag_ask_response_model.g.dart';

@JsonSerializable()
class RagAskResponseModel {
  final String? id;
  final String? queryText;
  final double? scoreTrust;
  final int? relevanceLevel;
  final String? queryDateTime;
  final String? generatedResponse;
  final String? doctorId;
  final String? patientId;
  final List<String>? sources;

  RagAskResponseModel({
    this.id,
    this.queryText,
    this.scoreTrust,
    this.relevanceLevel,
    this.queryDateTime,
    this.generatedResponse,
    this.doctorId,
    this.patientId,
    this.sources,
  });

  factory RagAskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RagAskResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RagAskResponseModelToJson(this);
}
