import '../core/constants/api_constants.dart';

class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String role;
  final bool isActive;
  final String? profilePicture;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isActive,
    required this.profilePicture,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      role: (json['role'] as String).toLowerCase(),
      isActive: json['is_active'] as bool? ?? true,
      profilePicture: json['profile_picture'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'role': role,
        'is_active': isActive,
        'profile_picture': profilePicture,
        'created_at': createdAt.toIso8601String(),
      };

  bool get isAdmin => role == AppRoles.admin;
  bool get isPassenger => role == AppRoles.passenger;

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
