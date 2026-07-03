import 'package:hive_flutter/hive_flutter.dart';

/// Hive দিয়ে access_token, token_type এবং user info persist করার জন্য
/// centralized storage helper।
class HiveStorage {
  HiveStorage._();

  static const String _boxName = "auth_box";
  static const String _tokenKey = "access_token";
  static const String _tokenTypeKey = "token_type";
  static const String _userKey = "user";

  static Box? _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  static Box get _instance {
    if (_box == null || !_box!.isOpen) {
      throw Exception("HiveStorage.init() call করা হয়নি।");
    }
    return _box!;
  }

  static Future<void> saveToken(String token, String tokenType) async {
    await _instance.put(_tokenKey, token);
    await _instance.put(_tokenTypeKey, tokenType);
  }

  static String? get token => _instance.get(_tokenKey) as String?;

  static String? get tokenType => _instance.get(_tokenTypeKey) as String?;

  static Future<void> saveUser(Map<String, dynamic> user) async {
    await _instance.put(_userKey, user);
  }

  static Map<String, dynamic>? get user {
    final data = _instance.get(_userKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  static bool get isLoggedIn => token != null && token!.isNotEmpty;

  static Future<void> clear() async {
    await _instance.clear();
  }
}
