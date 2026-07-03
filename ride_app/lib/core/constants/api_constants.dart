class ApiConstants {
  ApiConstants._();

  // TODO: আপনার আসল backend base URL এখানে বসান
  static const String baseUrl = "https://your-api-domain.com";

  static const String register = "/api/v1/auth/register";
  static const String login = "/api/v1/auth/login";
  static const String me = "/api/v1/auth/me";
  static const String profilePicture = "/api/v1/auth/me/profile-picture";
  static const String profilePicturePreview =
      "/api/v1/auth/me/profile-picture/preview";
}

class AppRoles {
  AppRoles._();

  static const String admin = "admin";
  static const String passenger = "passenger";
}
