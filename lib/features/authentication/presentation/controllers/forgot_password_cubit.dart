import 'package:bloc/bloc.dart';
import 'package:cortexia/features/authentication/data/models/forgot_password_request_body.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:flutter/material.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepoInterface _authRepo;

  ForgotPasswordCubit(this._authRepo) : super(ForgotPasswordInitial());

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> emitForgotPasswordStates() async {
    emit(ForgotPasswordLoading());

    final response = await _authRepo.forgotPassword(
      ForgotPasswordRequestBody(
        email: emailController.text,
      ),
    );

    response.when(
      onSuccess: (forgotPasswordResponse) {
        emit(ForgotPasswordSuccess(forgotPasswordResponse));
      },
      onError: (apiErrorModel) {
        // Here we take the first error message like we do in Login
        emit(ForgotPasswordError(message: apiErrorModel.messages.first));
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
