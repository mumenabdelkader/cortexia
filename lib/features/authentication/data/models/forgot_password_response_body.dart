import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response_body.g.dart';

@JsonSerializable()
class ForgotPasswordResponseBody {
  final bool? success;
  final String? message;
  final bool? data;

  ForgotPasswordResponseBody({this.success, this.message, this.data});

  factory ForgotPasswordResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseBodyFromJson(json);
}
