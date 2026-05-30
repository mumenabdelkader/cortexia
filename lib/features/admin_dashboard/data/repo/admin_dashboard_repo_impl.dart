import 'package:cortexia/core/networking/api_error_handler.dart';
import 'package:cortexia/core/networking/api_result.dart';
import 'package:cortexia/features/admin_dashboard/data/apis/admin_dashboard_service.dart';
import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/data/models/dashboard_summary_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/paged_result_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/role_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/room_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/user_with_roles_model.dart';
import 'package:cortexia/features/admin_dashboard/data/models/nurse_model.dart';
import 'package:cortexia/features/doctor/data/models/doctor_model.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';

class AdminDashboardRepoImpl implements AdminDashboardRepoInterface {
  final AdminDashboardService _service;

  AdminDashboardRepoImpl(this._service);

  // ── Summary ───────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<DashboardSummaryModel>> getDashboardSummary() async {
    try {
      final response = await _service.getDashboardSummary();
      final data = response['data'] as Map<String, dynamic>;
      return ApiResult.success(DashboardSummaryModel.fromJson(data));
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Audit Logs ────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<AuditLogPagedResult>> getAuditLogs({
    required int pageNumber,
    required int pageSize,
    String? tableName,
    String? userId,
  }) async {
    try {
      final response = await _service.getAuditLogs(
        pageNumber: pageNumber,
        pageSize: pageSize,
        tableName: tableName,
        userId: userId,
      );
      final data = response['data'] as Map<String, dynamic>;
      return ApiResult.success(AuditLogPagedResult.fromJson(data));
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Roles ─────────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<List<RoleModel>>> getRoles() async {
    try {
      final response = await _service.getRoles();
      final dataList = response['data'] as List<dynamic>;
      final roles = dataList
          .map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(roles);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> createRole(CreateRoleRequest request) async {
    try {
      final response = await _service.createRole(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteRole(String roleId) async {
    try {
      final response = await _service.deleteRole(roleId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Users ─────────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<List<UserWithRolesModel>>> getUsersWithRoles() async {
    try {
      final response = await _service.getUsersWithRoles();
      final dataList = response['data'] as List<dynamic>;
      final users = dataList
          .map((e) => UserWithRolesModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(users);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> assignRole(AssignRoleRequest request) async {
    try {
      final response = await _service.assignRole(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> removeRole(RemoveRoleRequest request) async {
    try {
      final response = await _service.removeRole(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> toggleUserStatus(
    ToggleUserStatusRequest request,
  ) async {
    try {
      final response = await _service.toggleUserStatus(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> forceResetPassword(
    ForceResetPasswordRequest request,
  ) async {
    try {
      final response = await _service.forceResetPassword(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> createAdmin(CreateAdminRequest request) async {
    try {
      final response = await _service.createAdmin(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> createUser(CreateUserRequest request) async {
    try {
      final response = await _service.createUser(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Doctors ───────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<List<DoctorModel>>> getDoctors() async {
    try {
      final response = await _service.getDoctors();
      final dataList = response as List<dynamic>;
      final doctors = dataList
          .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(doctors);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> updateDoctor(
      String email, UpdateDoctorRequest request) async {
    try {
      final response = await _service.updateDoctor(email, request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Nurses ────────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<List<NurseModel>>> getNurses() async {
    try {
      final response = await _service.getNurses();
      final dataList = response['data'] as List<dynamic>;
      final nurses = dataList
          .map((e) => NurseModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(nurses);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> updateNurse(
      String email, UpdateNurseRequest request) async {
    try {
      final response = await _service.updateNurse(email, request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Rooms ─────────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<List<RoomModel>>> getRooms() async {
    try {
      final response = await _service.getRooms();
      final dataList = response as List<dynamic>;
      final rooms = dataList
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(rooms);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> createRoom(CreateRoomRequest request) async {
    try {
      final response = await _service.createRoom(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> updateRoom(UpdateRoomRequest request) async {
    try {
      final response = await _service.updateRoom(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> toggleRoomAvailability(
    ToggleRoomAvailabilityRequest request,
  ) async {
    try {
      final response = await _service.toggleRoomAvailability(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  // ── Beds ──────────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<dynamic>> createBed(CreateBedRequest request) async {
    try {
      final response = await _service.createBed(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> updateBed(UpdateBedRequest request) async {
    try {
      final response = await _service.updateBed(request);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> deleteBed(String bedId) async {
    try {
      final response = await _service.deleteBed(bedId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(ApiErrorHandler.handle(e));
    }
  }
}
