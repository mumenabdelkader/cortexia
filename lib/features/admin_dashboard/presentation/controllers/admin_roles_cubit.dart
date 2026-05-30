import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_roles_state.dart';

const String kGetRoles = 'getRoles';
const String kCreateRole = 'createRole';
const String kDeleteRole = 'deleteRole';

class AdminRolesCubit extends Cubit<AdminRolesState> {
  final AdminDashboardRepoInterface _repo;

  AdminRolesCubit(this._repo) : super(AdminRolesInitial());

  Future<void> getRoles() async {
    emit(AdminRolesLoading());
    final result = await _repo.getRoles();
    result.when(
      onSuccess: (data) =>
          emit(AdminRolesSuccess(operation: kGetRoles, data: data)),
      onError: (error) => emit(AdminRolesError(message: error.messages.first)),
    );
  }

  Future<void> createRole(String roleName) async {
    emit(AdminRolesLoading());
    final result = await _repo.createRole(CreateRoleRequest(roleName: roleName));
    result.when(
      onSuccess: (data) =>
          emit(AdminRolesSuccess(operation: kCreateRole, data: data)),
      onError: (error) => emit(AdminRolesError(message: error.messages.first)),
    );
  }

  Future<void> deleteRole(String roleId) async {
    emit(AdminRolesLoading());
    final result = await _repo.deleteRole(roleId);
    result.when(
      onSuccess: (data) =>
          emit(AdminRolesSuccess(operation: kDeleteRole, data: data)),
      onError: (error) => emit(AdminRolesError(message: error.messages.first)),
    );
  }
}
