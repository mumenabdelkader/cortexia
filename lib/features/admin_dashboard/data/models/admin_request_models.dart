import 'package:json_annotation/json_annotation.dart';

part 'admin_request_models.g.dart';

// ── Create Admin ────────────────────────────────────────────────────────────

@JsonSerializable()
class CreateAdminRequest {
  final String email;
  final String password;
  final String username;
  final String fullName;

  const CreateAdminRequest({
    required this.email,
    required this.password,
    required this.username,
    required this.fullName,
  });

  factory CreateAdminRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAdminRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAdminRequestToJson(this);
}

// ── Create Role ─────────────────────────────────────────────────────────────

@JsonSerializable()
class CreateRoleRequest {
  final String roleName;

  const CreateRoleRequest({required this.roleName});

  factory CreateRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoleRequestToJson(this);
}

// ── Assign / Remove Role ────────────────────────────────────────────────────

@JsonSerializable()
class AssignRoleRequest {
  final String userId;
  final String roleName;

  const AssignRoleRequest({required this.userId, required this.roleName});

  factory AssignRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssignRoleRequestToJson(this);
}

@JsonSerializable()
class RemoveRoleRequest {
  final String userId;
  final String roleName;

  const RemoveRoleRequest({required this.userId, required this.roleName});

  factory RemoveRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveRoleRequestToJson(this);
}

// ── Toggle User Status ───────────────────────────────────────────────────────

@JsonSerializable()
class ToggleUserStatusRequest {
  final String id;

  const ToggleUserStatusRequest({required this.id});

  factory ToggleUserStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$ToggleUserStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleUserStatusRequestToJson(this);
}

// ── Force Reset Password ─────────────────────────────────────────────────────

@JsonSerializable()
class ForceResetPasswordRequest {
  final String userId;
  final String newPassword;

  const ForceResetPasswordRequest({
    required this.userId,
    required this.newPassword,
  });

  factory ForceResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForceResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForceResetPasswordRequestToJson(this);
}

// ── Users Management (Doctor/Nurse) ──────────────────────────────────────────

@JsonSerializable()
class CreateUserRequest {
  final String email;
  final String password;
  final String role;
  final String fullName;
  final String phoneNumber;
  final String dateOfBirth;
  final int gender;
  final String nationalId;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final int shift;
  final String department;
  final String? specialty;
  final int? doctorRole;
  final int? experienceYears;
  final int? nurseRole;

  const CreateUserRequest({
    required this.email,
    required this.password,
    required this.role,
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.nationalId,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.shift,
    required this.department,
    this.specialty,
    this.doctorRole,
    this.experienceYears,
    this.nurseRole,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);
}

@JsonSerializable()
class UpdateDoctorRequest {
  final String fullName;
  final String phoneNumber;
  final String dateOfBirth;
  final int gender;
  final String nationalId;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final int shift;
  final String department;
  final String specialty;
  final int doctorRole;
  final int experienceYears;

  const UpdateDoctorRequest({
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.nationalId,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.shift,
    required this.department,
    required this.specialty,
    required this.doctorRole,
    required this.experienceYears,
  });

  factory UpdateDoctorRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateDoctorRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDoctorRequestToJson(this);
}

@JsonSerializable()
class UpdateNurseRequest {
  final String fullName;
  final String phoneNumber;
  final String dateOfBirth;
  final int gender;
  final String nationalId;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final int shift;
  final String department;
  final int role;

  const UpdateNurseRequest({
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.nationalId,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.shift,
    required this.department,
    required this.role,
  });

  factory UpdateNurseRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNurseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNurseRequestToJson(this);
}

// ── Create Room ──────────────────────────────────────────────────────────────


@JsonSerializable()
class CreateRoomRequest {
  final String roomNumber;
  final int roomType;
  final int capacity;

  const CreateRoomRequest({
    required this.roomNumber,
    required this.roomType,
    required this.capacity,
  });

  factory CreateRoomRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRoomRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoomRequestToJson(this);
}

// ── Update Room ──────────────────────────────────────────────────────────────

@JsonSerializable()
class UpdateRoomRequest {
  final String id;
  final String roomNumber;
  final int roomType;
  final int capacity;
  final bool isAvailable;

  const UpdateRoomRequest({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.capacity,
    required this.isAvailable,
  });

  factory UpdateRoomRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoomRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRoomRequestToJson(this);
}

// ── Toggle Room Availability ─────────────────────────────────────────────────

@JsonSerializable()
class ToggleRoomAvailabilityRequest {
  final String roomId;

  const ToggleRoomAvailabilityRequest({required this.roomId});

  factory ToggleRoomAvailabilityRequest.fromJson(Map<String, dynamic> json) =>
      _$ToggleRoomAvailabilityRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ToggleRoomAvailabilityRequestToJson(this);
}

// ── Create Bed ───────────────────────────────────────────────────────────────

@JsonSerializable()
class CreateBedRequest {
  final String roomId;
  final String bedNumber;

  const CreateBedRequest({required this.roomId, required this.bedNumber});

  factory CreateBedRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBedRequestToJson(this);
}

// ── Update Bed ───────────────────────────────────────────────────────────────

@JsonSerializable()
class UpdateBedRequest {
  final String bedId;
  final String bedNumber;
  final int status;

  const UpdateBedRequest({
    required this.bedId,
    required this.bedNumber,
    required this.status,
  });

  factory UpdateBedRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBedRequestToJson(this);
}

// ── Create Schedule ──────────────────────────────────────────────────────────

@JsonSerializable()
class CreateScheduleRequest {
  final String startDate;
  final String endDate;
  final List<int> daysOfWeek;
  final String startTime;
  final String endTime;

  const CreateScheduleRequest({
    required this.startDate,
    required this.endDate,
    required this.daysOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory CreateScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateScheduleRequestToJson(this);
}
