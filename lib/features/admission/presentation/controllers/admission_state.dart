import 'package:flutter/foundation.dart';
import 'package:cortexia/features/admission/data/models/admission_response_body.dart';

@immutable
abstract class AdmissionState {}

class AdmissionInitial extends AdmissionState {}

class AdmissionLoading extends AdmissionState {}

class AdmissionSuccess extends AdmissionState {
  final List<AdmissionResponseBody> admissions;
  AdmissionSuccess(this.admissions);
}

class AdmissionError extends AdmissionState {
  final String message;
  AdmissionError({required this.message});
}
