// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordResponseBody _$ResetPasswordResponseBodyFromJson(
  Map<String, dynamic> json,
) => ResetPasswordResponseBody(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  data: json['data'] as bool?,
);

Map<String, dynamic> _$ResetPasswordResponseBodyToJson(
  ResetPasswordResponseBody instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
