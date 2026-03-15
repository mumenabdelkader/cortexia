import 'package:dio/dio.dart';

abstract class ApiHelper {
  Future<Response> getData({required String path, Map<String, dynamic>? queryParameters});
  Future<Response> postData({required String path, Map<String, dynamic>? queryParameters, dynamic body,FormData bodyFormData});
  Future<Response> putData({required String path, Map<String, dynamic>? queryParameters,dynamic body});
  Future<Response> patchData({required String path, Map<String, dynamic>? queryParameters});
  Future<Response> deleteData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body});

  Future<Response> uploadFile({required String path, required String filePath, Map<String, dynamic>? queryParameters});
}