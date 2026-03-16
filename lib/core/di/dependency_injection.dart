import 'package:cortexia/features/authentication/data/apis/auth_service.dart';
import 'package:cortexia/features/authentication/data/repo/repo_imp.dart';
import 'package:cortexia/features/authentication/domain/repo/repo_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Core
import '../api_helper/api_helper.dart';
import '../api_helper/dio_helper.dart';

// Auth Feature

final GetIt locator = GetIt.instance;

Future<void> setupGetIt() async {
  /* ------------------------------ CORE ---------------------------------- */

  // تسجيل الـ DioHelper كـ Singleton
  locator.registerLazySingleton<ApiHelper>(() => DioHelper());

  // بنسحب نسخة الـ Dio اللي متظبطة جوه الـ DioHelper (عشان الـ Interceptors والـ BaseUrl)
  // ملحوظة: تأكد أن متغير dio في كلاس DioHelper ليس private (بدون _)
  final dio = (locator<ApiHelper>() as DioHelper).dio;

  /* --------------------------- AUTH FEATURE ------------------------------ */

  // 1. تسجيل الـ API Service (الخاصة بالـ Retrofit)
  locator.registerLazySingleton<AuthService>(() => AuthService(dio));

  // 2. تسجيل الـ Repository
  // بنستخدم الـ Interface كـ Type والـ Implementation كـ Factory
  locator.registerLazySingleton<AuthRepoInterface>(
        () => AuthRepositoryImp(locator<AuthService>()),
  );
}