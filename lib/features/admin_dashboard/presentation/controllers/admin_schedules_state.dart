part of 'admin_schedules_cubit.dart';

@immutable
abstract class AdminSchedulesState {}

class AdminSchedulesInitial extends AdminSchedulesState {}

class AdminSchedulesLoading extends AdminSchedulesState {}

class AdminSchedulesLoaded extends AdminSchedulesState {
  final List<ScheduleModel> schedules;

  AdminSchedulesLoaded(this.schedules);
}

class AdminSchedulesSuccess extends AdminSchedulesState {
  final String operation;
  final dynamic data;

  AdminSchedulesSuccess({required this.operation, this.data});
}

class AdminSchedulesError extends AdminSchedulesState {
  final String message;

  AdminSchedulesError({required this.message});
}
