import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_interceptors.dart';

var _options = BaseOptions(
  contentType: "application/json",
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  sendTimeout: const Duration(seconds: 60),
);

Dio buildAuthDioClient() {
  final dio = Dio(_options);
  if (kDebugMode) {
    dio.interceptors.addAll([LogInterceptor(responseBody: true)]);
  }
  return dio;
}

Dio buildDioClient() {
  final dio = Dio(_options);
  dio.interceptors.addAll([TokenInterceptor()]);
  if (kDebugMode) {
    dio.interceptors.addAll([
      LogInterceptor(responseBody: true, requestBody: true),
    ]);
  }
  return dio;
}
