import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';
import '../storage/hive_storage.dart';

/// একটাই shared Dio instance — যেটা প্রতিটা request এ automatic
/// Authorization header attach করে দেয় (যদি token থাকে)।
class DioClient {
  DioClient._();

  static Dio? _dio;

  static Dio get instance {
    _dio ??= _build();
    return _dio!;
  }

  static Dio _build() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = HiveStorage.token;
          final tokenType = HiveStorage.tokenType ?? "bearer";
          if (token != null) {
            options.headers["Authorization"] =
                "${_capitalize(tokenType)} $token";
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // 401 হলে ভবিষ্যতে এখানে auto-logout hook বসানো যাবে
          return handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }

    return dio;
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  /// Image preview এর মতো authenticated request এর জন্য raw headers
  static Map<String, String> get authHeaders {
    final token = HiveStorage.token;
    final tokenType = HiveStorage.tokenType ?? "bearer";
    if (token == null) return {};
    return {"Authorization": "${_capitalize(tokenType)} $token"};
  }
}
