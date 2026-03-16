import 'package:bloc/bloc.dart';
import 'package:cortexia/features/authentication/data/models/login_request_model.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
      onSuccess: (loginResponse) {
        emit(LoginSuccess(loginResponse));
      },
      onError: (apiErrorModel) {
        // بنأخد أول رسالة خطأ من القائمة اللي انت عرفتها في الـ ApiErrorModel
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