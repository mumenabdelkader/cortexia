// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  token: json['token'] as String?,
  email: json['email'] as String?,
  userId: json['userId'] as String?,
  roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'token': instance.token,
  'email': instance.email,
  'userId': instance.userId,
  'roles': instance.roles,
};
