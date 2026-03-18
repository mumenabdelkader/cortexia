import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cortexia/features/authentication/data/models/reset_password_request_body.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:cortexia/features/authentication/presentation/controllers/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepoInterface _authRepo;

  ResetPasswordCubit(this._authRepo) : super(ResetPasswordInitial());

  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String email = '';

  void emitResetPasswordStates() async {
    emit(ResetPasswordLoading());
    final response = await _authRepo.resetPassword(
      ResetPasswordRequestBody(
        email: email,
        otp: otpController.text,
        newPassword: newPasswordController.text,
      ),
    );

    response.when(
      onSuccess: (resetPasswordResponse) {
        if (resetPasswordResponse.success == true) {
          emit(ResetPasswordSuccess(resetPasswordResponse));
        } else {
          emit(ResetPasswordError(resetPasswordResponse.message ?? 'An error occurred'));
        }
      },
      onError: (error) {
        emit(ResetPasswordError(error.messages.isNotEmpty ? error.messages.first : 'Unknown error occurred'));
      },
    );
  }
}
