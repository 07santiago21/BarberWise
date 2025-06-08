import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/change_password.dart';

class AuthProvider with ChangeNotifier {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final GetCachedUserUseCase _getCached;
  final UpdateProfileUseCase _updateProfile;
  final ChangePasswordUseCase _changePassword;

  UserEntity? _user;
  String? errorMessage;

  AuthProvider({
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
        _changePassword = changePassword;

  UserEntity? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<void> loadCached() async {
    _user = await _getCached();
    notifyListeners();
  }

  Future<bool> login(String email, String pass) async {
    try {
      _user = await _signIn(email, pass);
      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(
      String name, String phone, String email, String pass) async {
    try {
      _user = await _signUp(name, phone, email, pass);
      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _signOut();
    _user = null;
    notifyListeners();
  }

  Future<bool> updateProfile(String name, String phone) async {
    try {
      await _updateProfile(name, phone);
      final old = _user!;
      _user = UserEntity(
        uid: old.uid,
        email: old.email,
        name: name,
        phone: phone,
      );
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> changePassword(String newPassword) async {
    try {
      await _changePassword(newPassword);
      errorMessage = null;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
