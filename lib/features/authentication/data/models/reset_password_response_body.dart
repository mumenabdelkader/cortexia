import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response_body.g.dart';

@JsonSerializable()
class ResetPasswordResponseBody {
  final bool? success;
  final String? message;
  final bool? data;

  ResetPasswordResponseBody({this.success, this.message, this.data});

  factory ResetPasswordResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseBodyFromJson(json);
}
