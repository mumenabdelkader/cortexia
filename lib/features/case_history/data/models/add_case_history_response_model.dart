import 'package:json_annotation/json_annotation.dart';

part 'add_case_history_response_model.g.dart';

@JsonSerializable()
class AddCaseHistoryResponseModel {
  final String? id;

  AddCaseHistoryResponseModel({this.id});

  factory AddCaseHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddCaseHistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCaseHistoryResponseModelToJson(this);
}
