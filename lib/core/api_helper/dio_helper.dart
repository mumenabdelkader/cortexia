import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/shared_pref_helper.dart';
import 'api_helper.dart';
import '../networking/api_constants.dart';

class DioHelper implements ApiHelper {
  // 🔹 جعلنا المتغير public بإزالة الـ (_) لكي يراه الـ GetIt
  final Dio dio;

  DioHelper()
      : dio = Dio( // تغيير الاسم هنا أيضاً
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 60),
      headers: { "Accept": "application/json" },
    ),
  ) {
    // 🔹 استبدل كل _dio بـ dio داخل الـ constructor والـ methods
    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Accept"] = "application/json";
          final token = await _getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          } else {
            options.headers.remove("Authorization");
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final requestOptions = error.requestOptions;
          if (error.response?.statusCode == 401) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove("token");
          }

          // Retry logic (using 'dio' instead of '_dio')
          final isGet = requestOptions.method.toUpperCase() == 'GET';
          final isConnectionError = error.type == DioExceptionType.connectionError;
          final alreadyRetried = requestOptions.extra["_retried_once"] == true;

          if (isGet && isConnectionError && !alreadyRetried) {
            requestOptions.extra["_retried_once"] = true;
            try {
              final response = await dio.request(
                requestOptions.path,
                options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers,
                  responseType: requestOptions.responseType,
                  contentType: requestOptions.contentType,
                  followRedirects: requestOptions.followRedirects,
                  receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
                  validateStatus: requestOptions.validateStatus,
                ),
                data: requestOptions.data,
                queryParameters: requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (_) {}
          }
          handler.next(error);
        },
      ),
    ]);
  }

  // 🔹 تأكد من تحديث كل الـ Overrides لاستخدام 'dio' بدلاً من '_dio'
  @override
  Future<Response> getData({required String path, Map<String, dynamic>? queryParameters}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> postData({required String path, Map<String, dynamic>? queryParameters, dynamic body, FormData? bodyFormData}) async {
    return dio.post(path, data: body ?? bodyFormData, queryParameters: queryParameters);
  }

  @override
  Future<Response> putData({required String path, Map<String, dynamic>? queryParameters, dynamic body}) async {
    Options options = (body is FormData)
        ? Options(contentType: "multipart/form-data")
        : Options(contentType: "application/json");
    return dio.put(path, data: body, queryParameters: queryParameters, options: options);
  }

  @override
  Future<Response> patchData({required String path, Map<String, dynamic>? queryParameters}) async {
    return dio.patch(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> deleteData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body}) async {
    return dio.delete(path, data: body, queryParameters: queryParameters);
  }

  @override
  Future<Response> uploadFile({required String path, required String filePath, String fieldName = "File", Map<String, dynamic>? queryParameters}) async {
    final file = await MultipartFile.fromFile(filePath);
    final formData = FormData.fromMap({ fieldName: file });
    return dio.post(path, data: formData, queryParameters: queryParameters, options: Options(headers: { "Content-Type": "multipart/form-data" }));
  }

  Future<String?> _getToken() async {
    return SharedPrefHelper.getStringSync("token");
  }
}