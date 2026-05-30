part of 'admin_nurses_cubit.dart';

@immutable
abstract class AdminNursesState {}

class AdminNursesInitial extends AdminNursesState {}

class AdminNursesLoading extends AdminNursesState {}

class AdminNursesLoaded extends AdminNursesState {
  final List<NurseModel> nurses;

  AdminNursesLoaded(this.nurses);
}

class AdminNursesSuccess extends AdminNursesState {
  final String operation;
  final dynamic data;

  AdminNursesSuccess({required this.operation, this.data});
}

class AdminNursesError extends AdminNursesState {
  final String message;

  AdminNursesError({required this.message});
}
