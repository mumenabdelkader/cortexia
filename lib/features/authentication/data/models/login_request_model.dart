import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart'; // تأكد أن اسم الملف login_request_model.dart

@JsonSerializable()
class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({this.email, this.password});

  // الربط مع الـ Boilerplate code اللي هيتولد
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}