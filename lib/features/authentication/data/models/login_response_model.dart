import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart'; // اسم الملف لازم يكون نفس اسم ملف الـ dart

@JsonSerializable()
class LoginResponseModel {
  bool? success;
  String? message;
  UserData? data;

  LoginResponseModel({this.success, this.message, this.data});

  // الربط مع الكود اللي هيتولد تلقائياً
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class UserData {
  String? token;
  String? email;
  String? userId;
  String? userIdInSystem;
  List<String>? roles;

  UserData({
    this.token,
    this.email,
    this.userId,
    this.userIdInSystem,
    this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
