// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordResponseBody _$ForgotPasswordResponseBodyFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResponseBody(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] as bool?,
);

Map<String, dynamic> _$ForgotPasswordResponseBodyToJson(
  ForgotPasswordResponseBody instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
