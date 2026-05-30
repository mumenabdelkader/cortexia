import 'package:cortexia/core/networking/api_constants.dart';
import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'admin_dashboard_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AdminDashboardService {
  factory AdminDashboardService(Dio dio, {String baseUrl}) =
      _AdminDashboardService;

  // ── Dashboard Summary ─────────────────────────────────────────────────────
  @GET(ApiConstants.adminDashboardSummary)
  Future<dynamic> getDashboardSummary();

  // ── Audit Logs ────────────────────────────────────────────────────────────
  @GET(ApiConstants.adminAuditLogs)
  Future<dynamic> getAuditLogs({
    @Query('PageNumber') required int pageNumber,
    @Query('PageSize') required int pageSize,
    @Query('TableName') String? tableName,
    @Query('UserId') String? userId,
  });

  // ── Roles ─────────────────────────────────────────────────────────────────
  @GET(ApiConstants.adminRoles)
  Future<dynamic> getRoles();

  @POST(ApiConstants.adminCreateRole)
  Future<dynamic> createRole(@Body() CreateRoleRequest body);

  @DELETE('/api/admin-dashboard/delete-role/{roleId}')
  Future<dynamic> deleteRole(@Path('roleId') String roleId);

  // ── Users ─────────────────────────────────────────────────────────────────
  @GET(ApiConstants.adminUsersWithRoles)
  Future<dynamic> getUsersWithRoles();

  @POST(ApiConstants.adminAssignRole)
  Future<dynamic> assignRole(@Body() AssignRoleRequest body);

  @POST(ApiConstants.adminRemoveRole)
  Future<dynamic> removeRole(@Body() RemoveRoleRequest body);

  @PUT(ApiConstants.adminToggleUserStatus)
  Future<dynamic> toggleUserStatus(@Body() ToggleUserStatusRequest body);

  @POST(ApiConstants.adminForceResetPassword)
  Future<dynamic> forceResetPassword(@Body() ForceResetPasswordRequest body);

  @POST(ApiConstants.adminCreateAdmin)
  Future<dynamic> createAdmin(@Body() CreateAdminRequest body);

  @POST('/api/admin-dashboard/users')
  Future<dynamic> createUser(@Body() CreateUserRequest body);

  @PUT('/api/admin-dashboard/doctor-user/{email}')
  Future<dynamic> updateDoctor(
      @Path('email') String email, @Body() UpdateDoctorRequest body);

  @PUT('/api/admin-dashboard/nurse-user/{email}')
  Future<dynamic> updateNurse(
      @Path('email') String email, @Body() UpdateNurseRequest body);

  @GET('/api/Doctors')
  Future<dynamic> getDoctors();

  @GET('/api/Nurses')
  Future<dynamic> getNurses();

  // ── Rooms ─────────────────────────────────────────────────────────────────
  @GET(ApiConstants.rooms)
  Future<dynamic> getRooms();
  @POST(ApiConstants.adminCreateRoom)
  Future<dynamic> createRoom(@Body() CreateRoomRequest body);

  @PUT(ApiConstants.adminUpdateRoom)
  Future<dynamic> updateRoom(@Body() UpdateRoomRequest body);

  @PUT(ApiConstants.adminToggleRoomAvailability)
  Future<dynamic> toggleRoomAvailability(
      @Body() ToggleRoomAvailabilityRequest body);

  // ── Beds ──────────────────────────────────────────────────────────────────
  @POST(ApiConstants.adminCreateBed)
  Future<dynamic> createBed(@Body() CreateBedRequest body);

  @PUT(ApiConstants.adminUpdateBed)
  Future<dynamic> updateBed(@Body() UpdateBedRequest body);

  @DELETE('/api/admin-dashboard/delete-bed/{bedId}')
  Future<dynamic> deleteBed(@Path('bedId') String bedId);
}
