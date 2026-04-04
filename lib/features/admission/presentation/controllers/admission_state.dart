import 'package:flutter/foundation.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';
import 'package:cortexia/features/admission/data/models/room_model.dart';

@immutable
abstract class AdmissionState {}

class AdmissionInitial extends AdmissionState {}

class AdmissionLoading extends AdmissionState {}

class RoomsLoading extends AdmissionState {}

class RoomsLoaded extends AdmissionState {
  final List<RoomModel> rooms;
  RoomsLoaded(this.rooms);
}

class AdmissionSuccess extends AdmissionState {
  final List<AdmissionResponseBody> admissions;
  AdmissionSuccess(this.admissions);
}

class AdmitPatientSuccess extends AdmissionState {
  final dynamic data;
  AdmitPatientSuccess(this.data);
}

class AdmissionError extends AdmissionState {
  final String message;
  AdmissionError({required this.message});
}
