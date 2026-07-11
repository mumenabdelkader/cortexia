part of 'admin_doctors_cubit.dart';

@immutable
abstract class AdminDoctorsState {}

class AdminDoctorsInitial extends AdminDoctorsState {}

class AdminDoctorsLoading extends AdminDoctorsState {}

class AdminDoctorsLoaded extends AdminDoctorsState {
  final List<DoctorModel> doctors;

  AdminDoctorsLoaded(this.doctors);
}

class AdminDoctorsSuccess extends AdminDoctorsState {
  final String operation;
  final dynamic data;

  AdminDoctorsSuccess({required this.operation, this.data});
}

class AdminDoctorsError extends AdminDoctorsState {
  final String message;

  AdminDoctorsError({required this.message});
}
