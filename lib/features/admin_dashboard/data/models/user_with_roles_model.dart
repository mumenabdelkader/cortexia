import 'package:json_annotation/json_annotation.dart';

part 'user_with_roles_model.g.dart';

@JsonSerializable()
class UserWithRolesModel {
  final String userId;
  final String userName;
  final List<String> roles;

  const UserWithRolesModel({
    required this.userId,
    required this.userName,
    required this.roles,
  });

  /// Returns the primary/first role, or empty string.
  String get primaryRole => roles.isNotEmpty ? roles.first : '';

  factory UserWithRolesModel.fromJson(Map<String, dynamic> json) =>
      _$UserWithRolesModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserWithRolesModelToJson(this);
}
