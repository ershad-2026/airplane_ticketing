import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/hive_storage.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus { unknown, authenticating, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _service;

  AuthNotifier(this._service) : super(const AuthState()) {
    _bootstrap();
  }

  /// অ্যাপ ওপেন হওয়ার সাথে সাথে সেভ করা token দিয়ে auto-login চেষ্টা করে
  Future<void> _bootstrap() async {
    if (!HiveStorage.isLoggedIn) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    try {
      final user = await _service.getMe();
      await HiveStorage.saveUser(user.toJson());
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (_) {
      await HiveStorage.clear();
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required String role,
  }) async {
    state = state.copyWith(
        status: AuthStatus.authenticating, clearError: true);
    try {
      await _service.register(
        fullName: fullName,
        email: email,
        password: password,
        role: role,
      );
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(
        status: AuthStatus.authenticating, clearError: true);
    try {
      final result = await _service.login(email: email, password: password);
      await HiveStorage.saveToken(result.accessToken, result.tokenType);
      await HiveStorage.saveUser(result.user.toJson());
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: result.user,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> uploadProfilePicture(String filePath) async {
    try {
      final user = await _service.uploadProfilePicture(filePath);
      await HiveStorage.saveUser(user.toJson());
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<void> refreshMe() async {
    try {
      final user = await _service.getMe();
      await HiveStorage.saveUser(user.toJson());
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (_) {
      // silent refresh fail — UI অপরিবর্তিত থাকবে
    }
  }

  Future<void> logout() async {
    await HiveStorage.clear();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});
