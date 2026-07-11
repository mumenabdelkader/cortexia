part of 'admin_rooms_cubit.dart';

@immutable
abstract class AdminRoomsState {}

class AdminRoomsInitial extends AdminRoomsState {}

class AdminRoomsLoading extends AdminRoomsState {}

class AdminRoomsLoaded extends AdminRoomsState {
  final List<RoomModel> rooms;

  AdminRoomsLoaded(this.rooms);
}

class AdminRoomsSuccess extends AdminRoomsState {
  final String operation;
  final dynamic data;

  AdminRoomsSuccess({required this.operation, this.data});
}

class AdminRoomsError extends AdminRoomsState {
  final String message;

  AdminRoomsError({required this.message});
}
