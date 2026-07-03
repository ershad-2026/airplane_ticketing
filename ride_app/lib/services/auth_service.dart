import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';
import '../core/network/dio_client.dart';
import '../models/user_model.dart';

class LoginResult {
  final String accessToken;
  final String tokenType;
  final UserModel user;

  LoginResult({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });
}

/// আপনার ৫টা endpoint এর সাথে সরাসরি map করা service layer:
/// 1. POST /api/v1/auth/register
/// 2. POST /api/v1/auth/login
/// 3. GET  /api/v1/auth/me
/// 4. POST /api/v1/auth/me/profile-picture
/// 5. GET  /api/v1/auth/me/profile-picture/preview
class AuthService {
  final Dio _dio = DioClient.instance;

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: {
          "full_name": fullName,
          "email": email,
          "password": password,
          "role": role,
        },
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {"email": email, "password": password},
      );
      final data = response.data as Map<String, dynamic>;
      return LoginResult(
        accessToken: data['access_token'] as String,
        tokenType: data['token_type'] as String,
        user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserModel> getMe() async {
    try {
      final response = await _dio.get(ApiConstants.me);
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<UserModel> uploadProfilePicture(String filePath) async {
    try {
      final fileName = filePath.split('/').last;
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
      });
      final response = await _dio.post(
        ApiConstants.profilePicture,
        data: formData,
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  /// Preview endpoint এর পূর্ণ URL — Image.network এ authHeaders সহ ব্যবহার করা হয়
  String profilePicturePreviewUrl() {
    return "${ApiConstants.baseUrl}${ApiConstants.profilePicturePreview}";
  }

  String _mapError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['detail'] != null) {
      final detail = data['detail'];
      if (detail is String) return detail;
      if (detail is List && detail.isNotEmpty) {
        return detail.first.toString();
      }
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "সার্ভারে সংযোগ করা যাচ্ছে না, আবার চেষ্টা করুন।";
    }
    return e.message ?? "কিছু একটা সমস্যা হয়েছে, আবার চেষ্টা করুন।";
  }
}
