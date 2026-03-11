
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_error_model.dart';
import 'dio_exception_type_extension.dart';
import 'local_status_codes.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic e) {
    if (e is ApiErrorModel){
      return e;
    }
    if (e is Exception) {
      if (e is DioException) {
        return e.when(
            connectionError: () => ApiErrorModel(
                  messages:
                    [  "No internet connection. Please check your Wi-Fi or mobile data."],
                  icon: Icons.wifi_off,
                  statusCode: LocalStatusCodes.connectionError,
                ),
            connectionTimeout: () => ApiErrorModel(
                  messages:
                      ["The connection took too long. Try checking your internet or try again later."],
                  icon: Icons.timer_off,
                  statusCode: LocalStatusCodes.connectionTimeout,
                ),
            sendTimeout: () => ApiErrorModel(
                  messages:
                    [  "Request timed out while sending data. Please try again."],
                  icon: Icons.send,
                  statusCode: LocalStatusCodes.sendTimeout,
                ),
            receiveTimeout: () => ApiErrorModel(
                  messages:
                     [ "Server took too long to respond. Please try again later."],
                  icon: Icons.downloading,
                  statusCode: LocalStatusCodes.receiveTimeout,
                ),
            badCertificate: () => ApiErrorModel(
                  messages:
                      ["Security issue detected with the server. Connection not secure."],
                  icon: Icons.security,
                  statusCode: LocalStatusCodes.badCertificate,
                ),
            badResponse: () => ApiErrorModel(
                messages:
                   [ "Server returned an unexpected response. Please try again."],
                icon: Icons.warning,
                statusCode:
                    e.response?.statusCode ?? LocalStatusCodes.badResponse),
            cancel: () => ApiErrorModel(
                  messages: ["The request was cancelled. Please try again."],
                  icon: Icons.cancel,
                  statusCode: LocalStatusCodes.cancel,
                ),
            unknown: () => ApiErrorModel(
                  messages:
                      ["Something went wrong. Please check your connection and try again."],
                  icon: Icons.error_outline,
                  statusCode: LocalStatusCodes.unknown,
                ));
      }
    }
    return ApiErrorModel(messages:["Unknown error"], icon: Icons.error, statusCode: LocalStatusCodes.unknown);
  }
}
