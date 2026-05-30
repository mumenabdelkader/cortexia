// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAdminRequest _$CreateAdminRequestFromJson(Map<String, dynamic> json) =>
    CreateAdminRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$CreateAdminRequestToJson(CreateAdminRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'fullName': instance.fullName,
    };

CreateRoleRequest _$CreateRoleRequestFromJson(Map<String, dynamic> json) =>
    CreateRoleRequest(roleName: json['roleName'] as String);

Map<String, dynamic> _$CreateRoleRequestToJson(CreateRoleRequest instance) =>
    <String, dynamic>{'roleName': instance.roleName};

AssignRoleRequest _$AssignRoleRequestFromJson(Map<String, dynamic> json) =>
    AssignRoleRequest(
      userId: json['userId'] as String,
      roleName: json['roleName'] as String,
    );

Map<String, dynamic> _$AssignRoleRequestToJson(AssignRoleRequest instance) =>
    <String, dynamic>{'userId': instance.userId, 'roleName': instance.roleName};

RemoveRoleRequest _$RemoveRoleRequestFromJson(Map<String, dynamic> json) =>
    RemoveRoleRequest(
      userId: json['userId'] as String,
      roleName: json['roleName'] as String,
    );

Map<String, dynamic> _$RemoveRoleRequestToJson(RemoveRoleRequest instance) =>
    <String, dynamic>{'userId': instance.userId, 'roleName': instance.roleName};

ToggleUserStatusRequest _$ToggleUserStatusRequestFromJson(
  Map<String, dynamic> json,
) => ToggleUserStatusRequest(id: json['id'] as String);

Map<String, dynamic> _$ToggleUserStatusRequestToJson(
  ToggleUserStatusRequest instance,
) => <String, dynamic>{'id': instance.id};

ForceResetPasswordRequest _$ForceResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForceResetPasswordRequest(
  userId: json['userId'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ForceResetPasswordRequestToJson(
  ForceResetPasswordRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'newPassword': instance.newPassword,
};

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    CreateUserRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: (json['gender'] as num).toInt(),
      nationalId: json['nationalId'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      shift: (json['shift'] as num).toInt(),
      department: json['department'] as String,
      specialty: json['specialty'] as String?,
      doctorRole: (json['doctorRole'] as num?)?.toInt(),
      experienceYears: (json['experienceYears'] as num?)?.toInt(),
      nurseRole: (json['nurseRole'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'nationalId': instance.nationalId,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'shift': instance.shift,
      'department': instance.department,
      'specialty': instance.specialty,
      'doctorRole': instance.doctorRole,
      'experienceYears': instance.experienceYears,
      'nurseRole': instance.nurseRole,
    };

UpdateDoctorRequest _$UpdateDoctorRequestFromJson(Map<String, dynamic> json) =>
    UpdateDoctorRequest(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: (json['gender'] as num).toInt(),
      nationalId: json['nationalId'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      shift: (json['shift'] as num).toInt(),
      department: json['department'] as String,
      specialty: json['specialty'] as String,
      doctorRole: (json['doctorRole'] as num).toInt(),
      experienceYears: (json['experienceYears'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateDoctorRequestToJson(
  UpdateDoctorRequest instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'phoneNumber': instance.phoneNumber,
  'dateOfBirth': instance.dateOfBirth,
  'gender': instance.gender,
  'nationalId': instance.nationalId,
  'street': instance.street,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
  'shift': instance.shift,
  'department': instance.department,
  'specialty': instance.specialty,
  'doctorRole': instance.doctorRole,
  'experienceYears': instance.experienceYears,
};

UpdateNurseRequest _$UpdateNurseRequestFromJson(Map<String, dynamic> json) =>
    UpdateNurseRequest(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: (json['gender'] as num).toInt(),
      nationalId: json['nationalId'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      shift: (json['shift'] as num).toInt(),
      department: json['department'] as String,
      role: (json['role'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateNurseRequestToJson(UpdateNurseRequest instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
      'nationalId': instance.nationalId,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'shift': instance.shift,
      'department': instance.department,
      'role': instance.role,
    };

CreateRoomRequest _$CreateRoomRequestFromJson(Map<String, dynamic> json) =>
    CreateRoomRequest(
      roomNumber: json['roomNumber'] as String,
      roomType: (json['roomType'] as num).toInt(),
      capacity: (json['capacity'] as num).toInt(),
    );

Map<String, dynamic> _$CreateRoomRequestToJson(CreateRoomRequest instance) =>
    <String, dynamic>{
      'roomNumber': instance.roomNumber,
      'roomType': instance.roomType,
      'capacity': instance.capacity,
    };

UpdateRoomRequest _$UpdateRoomRequestFromJson(Map<String, dynamic> json) =>
    UpdateRoomRequest(
      id: json['id'] as String,
      roomNumber: json['roomNumber'] as String,
      roomType: (json['roomType'] as num).toInt(),
      capacity: (json['capacity'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
    );

Map<String, dynamic> _$UpdateRoomRequestToJson(UpdateRoomRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomNumber': instance.roomNumber,
      'roomType': instance.roomType,
      'capacity': instance.capacity,
      'isAvailable': instance.isAvailable,
    };

ToggleRoomAvailabilityRequest _$ToggleRoomAvailabilityRequestFromJson(
  Map<String, dynamic> json,
) => ToggleRoomAvailabilityRequest(roomId: json['roomId'] as String);

Map<String, dynamic> _$ToggleRoomAvailabilityRequestToJson(
  ToggleRoomAvailabilityRequest instance,
) => <String, dynamic>{'roomId': instance.roomId};

CreateBedRequest _$CreateBedRequestFromJson(Map<String, dynamic> json) =>
    CreateBedRequest(
      roomId: json['roomId'] as String,
      bedNumber: json['bedNumber'] as String,
    );

Map<String, dynamic> _$CreateBedRequestToJson(CreateBedRequest instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'bedNumber': instance.bedNumber,
    };

UpdateBedRequest _$UpdateBedRequestFromJson(Map<String, dynamic> json) =>
    UpdateBedRequest(
      bedId: json['bedId'] as String,
      bedNumber: json['bedNumber'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateBedRequestToJson(UpdateBedRequest instance) =>
    <String, dynamic>{
      'bedId': instance.bedId,
      'bedNumber': instance.bedNumber,
      'status': instance.status,
    };
