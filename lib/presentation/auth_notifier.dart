// lib/presentation/auth_notifier.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/user_entity.dart';
import '../domain/usecases/sign_in_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';
import '../domain/usecases/sign_out_usecase.dart';
import '../domain/usecases/get_cached_user_usecase.dart';
import '../domain/usecases/update_profile_usecase.dart';
import '../domain/usecases/change_password.dart';

/// Estado inmutable
class AuthState {
  final UserEntity? user;
  final String? error;
  const AuthState({this.user, this.error});
}

/// Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final GetCachedUserUseCase _getCached;
  final UpdateProfileUseCase _updateProfile;
  final ChangePasswordUseCase _changePassword;

  AuthNotifier({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required SignOutUseCase signOut,
    required GetCachedUserUseCase getCached,
    required UpdateProfileUseCase updateProfile,
    required ChangePasswordUseCase changePassword,
  })  : _signIn = signIn,
        _signUp = signUp,
        _signOut = signOut,
        _getCached = getCached,
        _updateProfile = updateProfile,
        _changePassword = changePassword,
        super(const AuthState());

  Future<void> loadCached() async {
    final u = await _getCached();
    state = AuthState(user: u);
  }

  Future<bool> login(String email, String pass) async {
    try {
      final u = await _signIn(email, pass);
      state = AuthState(user: u);
      return true;
    } catch (e) {
      state = AuthState(user: null, error: e.toString());
      return false;
    }
  }

  Future<bool> register(
      String name, String phone, String email, String pass) async {
    try {
      final u = await _signUp(name, phone, email, pass);
      state = AuthState(user: u);
      return true;
    } catch (e) {
      state = AuthState(user: null, error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await _signOut();
    state = const AuthState(user: null);
  }

  Future<bool> updateProfile(String name, String phone) async {
    try {
      await _updateProfile(name, phone);
      final old = state.user!;
      state = AuthState(
          user: UserEntity(
        uid: old.uid,
        email: old.email,
        name: name,
        phone: phone,
      ));
      return true;
    } catch (e) {
      state = AuthState(user: state.user, error: e.toString());
      return false;
    }
  }

  Future<bool> changePassword(String newPassword) async {
    try {
      await _changePassword(newPassword);
      return true;
    } catch (e) {
      state = AuthState(user: state.user, error: e.toString());
      return false;
    }
  }
}
