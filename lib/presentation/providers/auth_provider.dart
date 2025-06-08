import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';

class AuthProvider with ChangeNotifier {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final GetCachedUserUseCase _getCached;

  UserEntity? _user;
  String? errorMessage;

  AuthProvider({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required SignOutUseCase signOut,
    required GetCachedUserUseCase getCached,
  })  : _signIn = signIn,
        _signUp = signUp,
        _signOut = signOut,
        _getCached = getCached;

  UserEntity? get user => _user;
  bool get isLoggedIn => _user != null;

  /// Carga usuario guardado en SharedPreferences al iniciar la app
  Future<void> loadCached() async {
    _user = await _getCached();
    notifyListeners();
  }

  /// Intenta iniciar sesión; captura errores de FirebaseAuth y guarda mensaje
  Future<bool> login(String email, String password) async {
    try {
      _user = await _signIn(email, password);
      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Registra un nuevo usuario
  Future<bool> register(String email, String password) async {
    try {
      _user = await _signUp(email, password);
      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Cierra sesión y limpia el cache
  Future<void> logout() async {
    await _signOut();
    _user = null;
    notifyListeners();
  }
}
