import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_users_state.dart';

const String kGetUsersWithRoles = 'getUsersWithRoles';
const String kAssignRole = 'assignRole';
const String kRemoveRole = 'removeRole';
const String kToggleUserStatus = 'toggleUserStatus';
const String kForceResetPassword = 'forceResetPassword';
const String kCreateAdmin = 'createAdmin';

class AdminUsersCubit extends Cubit<AdminUsersState> {
  final AdminDashboardRepoInterface _repo;

  AdminUsersCubit(this._repo) : super(AdminUsersInitial());

  Future<void> getUsersWithRoles() async {
    emit(AdminUsersLoading());
    final result = await _repo.getUsersWithRoles();
    result.when(
      onSuccess: (data) =>
          emit(AdminUsersSuccess(operation: kGetUsersWithRoles, data: data)),
      onError: (error) => emit(AdminUsersError(message: error.messages.first)),
    );
  }

  Future<void> assignRole({
    required String userId,
    required String roleName,
  }) async {
    emit(AdminUsersLoading());
    final result = await _repo
        .assignRole(AssignRoleRequest(userId: userId, roleName: roleName));
    result.when(
      onSuccess: (data) =>
          emit(AdminUsersSuccess(operation: kAssignRole, data: data)),
      onError: (error) => emit(AdminUsersError(message: error.messages.first)),
    );
  }

  Future<void> removeRole({
    required String userId,
    required String roleName,
  }) async {
    emit(AdminUsersLoading());
    final result = await _repo
        .removeRole(RemoveRoleRequest(userId: userId, roleName: roleName));
    result.when(
      onSuccess: (data) =>
          emit(AdminUsersSuccess(operation: kRemoveRole, data: data)),
      onError: (error) => emit(AdminUsersError(message: error.messages.first)),
    );
  }

  Future<void> toggleUserStatus(String userId) async {
    emit(AdminUsersLoading());
    final result = await _repo
        .toggleUserStatus(ToggleUserStatusRequest(id: userId));
    result.when(
      onSuccess: (data) =>
          emit(AdminUsersSuccess(operation: kToggleUserStatus, data: data)),
      onError: (error) => emit(AdminUsersError(message: error.messages.first)),
    );
  }

  Future<void> forceResetPassword({
    required String userId,
    required String newPassword,
  }) async {
    emit(AdminUsersLoading());
    final result = await _repo.forceResetPassword(
        ForceResetPasswordRequest(userId: userId, newPassword: newPassword));
    result.when(
      onSuccess: (data) =>
          emit(AdminUsersSuccess(operation: kForceResetPassword, data: data)),
      onError: (error) => emit(AdminUsersError(message: error.messages.first)),
    );
  }

  Future<void> createAdmin({
    required String email,
    required String password,
    required String username,
    required String fullName,
  }) async {
    emit(AdminUsersLoading());
    final result = await _repo.createAdmin(CreateAdminRequest(
      email: email,
      password: password,
      username: username,
      fullName: fullName,
    ));
    result.when(
      onSuccess: (data) =>
          emit(AdminUsersSuccess(operation: kCreateAdmin, data: data)),
      onError: (error) => emit(AdminUsersError(message: error.messages.first)),
    );
  }
}
