// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_with_roles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWithRolesModel _$UserWithRolesModelFromJson(Map<String, dynamic> json) =>
    UserWithRolesModel(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserWithRolesModelToJson(UserWithRolesModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'roles': instance.roles,
    };
