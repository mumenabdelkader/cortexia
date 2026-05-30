import 'package:cortexia/features/admin_dashboard/data/models/admin_request_models.dart';
import 'package:cortexia/features/admin_dashboard/data/models/room_model.dart';
import 'package:cortexia/features/admin_dashboard/domain/repo/admin_dashboard_repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_rooms_state.dart';

const String kCreateRoom = 'createRoom';
const String kUpdateRoom = 'updateRoom';
const String kToggleRoomAvailability = 'toggleRoomAvailability';

class AdminRoomsCubit extends Cubit<AdminRoomsState> {
  final AdminDashboardRepoInterface _repo;

  AdminRoomsCubit(this._repo) : super(AdminRoomsInitial());

  Future<void> getRooms() async {
    emit(AdminRoomsLoading());
    final result = await _repo.getRooms();
    result.when(
      onSuccess: (rooms) => emit(AdminRoomsLoaded(rooms)),
      onError: (error) => emit(AdminRoomsError(message: error.messages.first)),
    );
  }

  Future<void> createRoom({
    required String roomNumber,
    required int roomType,
    required int capacity,
  }) async {
    emit(AdminRoomsLoading());
    final result = await _repo.createRoom(CreateRoomRequest(
      roomNumber: roomNumber,
      roomType: roomType,
      capacity: capacity,
    ));
    result.when(
      onSuccess: (data) =>
          emit(AdminRoomsSuccess(operation: kCreateRoom, data: data)),
      onError: (error) => emit(AdminRoomsError(message: error.messages.first)),
    );
  }

  Future<void> updateRoom({
    required String id,
    required String roomNumber,
    required int roomType,
    required int capacity,
    required bool isAvailable,
  }) async {
    emit(AdminRoomsLoading());
    final result = await _repo.updateRoom(UpdateRoomRequest(
      id: id,
      roomNumber: roomNumber,
      roomType: roomType,
      capacity: capacity,
      isAvailable: isAvailable,
    ));
    result.when(
      onSuccess: (data) =>
          emit(AdminRoomsSuccess(operation: kUpdateRoom, data: data)),
      onError: (error) => emit(AdminRoomsError(message: error.messages.first)),
    );
  }

  Future<void> toggleRoomAvailability(String roomId) async {
    emit(AdminRoomsLoading());
    final result = await _repo
        .toggleRoomAvailability(ToggleRoomAvailabilityRequest(roomId: roomId));
    result.when(
      onSuccess: (data) => emit(AdminRoomsSuccess(
          operation: kToggleRoomAvailability, data: data)),
      onError: (error) => emit(AdminRoomsError(message: error.messages.first)),
    );
  }
}
