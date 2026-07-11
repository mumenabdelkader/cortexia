import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/data/models/dashboard_summary_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/paged_result_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/role_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/user_with_roles_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/room_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/nurse_model.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/schedule_model.dart';

abstract class AdminDashboardRepoInterface {
  // Summary
  Future<ApiResult<DashboardSummaryModel>> getDashboardSummary();

  // Audit Logs
  Future<ApiResult<AuditLogPagedResult>> getAuditLogs({
    required int pageNumber,
    required int pageSize,
    String? tableName,
    String? userId,
  });

  // Roles
  Future<ApiResult<List<RoleModel>>> getRoles();
  Future<ApiResult<dynamic>> createRole(CreateRoleRequest request);
  Future<ApiResult<dynamic>> deleteRole(String roleId);

  // Users
  Future<ApiResult<List<UserWithRolesModel>>> getUsersWithRoles();
  Future<ApiResult<dynamic>> assignRole(AssignRoleRequest request);
  Future<ApiResult<dynamic>> removeRole(RemoveRoleRequest request);
  Future<ApiResult<dynamic>> toggleUserStatus(
      ToggleUserStatusRequest request);
  Future<ApiResult<dynamic>> forceResetPassword(
      ForceResetPasswordRequest request);
  Future<ApiResult<dynamic>> createAdmin(CreateAdminRequest request);
  Future<ApiResult<dynamic>> createUser(CreateUserRequest request);

  // Doctors
  Future<ApiResult<List<DoctorModel>>> getDoctors();
  Future<ApiResult<dynamic>> updateDoctor(String email, UpdateDoctorRequest request);

  // Nurses
  Future<ApiResult<List<NurseModel>>> getNurses();
  Future<ApiResult<dynamic>> updateNurse(String email, UpdateNurseRequest request);

  // Rooms
  Future<ApiResult<List<RoomModel>>> getRooms();
  Future<ApiResult<dynamic>> createRoom(CreateRoomRequest request);
  Future<ApiResult<dynamic>> updateRoom(UpdateRoomRequest request);
  Future<ApiResult<dynamic>> toggleRoomAvailability(
      ToggleRoomAvailabilityRequest request);

  // Beds
  Future<ApiResult<dynamic>> createBed(CreateBedRequest request);
  Future<ApiResult<dynamic>> updateBed(UpdateBedRequest request);
  Future<ApiResult<dynamic>> deleteBed(String bedId);

  // Schedules
  Future<ApiResult<List<ScheduleModel>>> getStaffSchedules(String staffId);
  Future<ApiResult<dynamic>> createStaffSchedule(
      String staffId, CreateScheduleRequest request);
}
