import 'package:bloc/bloc.dart';
import 'package:cortexia/core/cache/app_cahe.dart';
import 'package:cortexia/features/authentication/data/models/login_request_model.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepoInterface _authRepo;

  // بنحقن الـ Repository من خلال الـ constructor
  LoginCubit(this._authRepo) : super(LoginInitial());

  // Controllers للـ TextFields عشان نسهل الاستخدام في الـ UI
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> emitLoginStates() async {
    emit(LoginLoading());

    final response = await _authRepo.login(
      LoginRequestModel(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    response.when(
      onSuccess: (loginResponse) async {
        if (loginResponse.data != null) {
          await AppCache.saveUserData(loginResponse.data!);
        }
        emit(LoginSuccess(loginResponse));
      },
      onError: (apiErrorModel) {
        emit(LoginError(message: apiErrorModel.messages.first));
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}