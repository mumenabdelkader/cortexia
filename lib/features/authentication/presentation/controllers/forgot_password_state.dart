import 'package:flutter/foundation.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess<T> extends ForgotPasswordState {
  final T data;
  ForgotPasswordSuccess(this.data);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError({required this.message});
}
