import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasources/auth_remote_datasource_impl.dart';
import '../data/datasources/local_storage_datasource_impl.dart';
import '../data/repositories_impl/auth_repository_impl.dart';

import '../domain/usecases/sign_in_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';
import '../domain/usecases/sign_out_usecase.dart';
import '../domain/usecases/get_cached_user_usecase.dart';
import '../domain/usecases/update_profile_usecase.dart';
import '../domain/usecases/change_password.dart';

import 'auth_notifier.dart';

/// 1) SharedPreferences — aquí definimos un Provider “vacío”
///    que sobreescribiremos en main.dart con la instancia real.
final sharedPrefsProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError(
      'El Provider de SharedPreferences debe overridearse en main.dart');
});

/// 2) DataSources
final authRemoteDsProvider = Provider((ref) => AuthRemoteDataSourceImpl());
final authLocalDsProvider = Provider<SharedPrefsLocalDataSource>((ref) {
  final prefs = ref.read(sharedPrefsProvider);
  return SharedPrefsLocalDataSource(prefs);
});

/// 3) Repositorio
final authRepoProvider = Provider((ref) => AuthRepositoryImpl(
      remote: ref.read(authRemoteDsProvider),
      local: ref.read(authLocalDsProvider),
    ));

/// 4) UseCases
final signInUseCaseProvider =
    Provider((ref) => SignInUseCase(ref.read(authRepoProvider)));
final signUpUseCaseProvider =
    Provider((ref) => SignUpUseCase(ref.read(authRepoProvider)));
final signOutUseCaseProvider =
    Provider((ref) => SignOutUseCase(ref.read(authRepoProvider)));
final getCachedUseCaseProvider =
    Provider((ref) => GetCachedUserUseCase(ref.read(authRepoProvider)));
final updateProfileUseCaseProvider =
    Provider((ref) => UpdateProfileUseCase(ref.read(authRepoProvider)));
final changePasswordUseCaseProvider =
    Provider((ref) => ChangePasswordUseCase(ref.read(authRepoProvider)));

/// 5) AuthNotifier
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    signIn: ref.read(signInUseCaseProvider),
    signUp: ref.read(signUpUseCaseProvider),
    signOut: ref.read(signOutUseCaseProvider),
    getCached: ref.read(getCachedUseCaseProvider),
    updateProfile: ref.read(updateProfileUseCaseProvider),
    changePassword: ref.read(changePasswordUseCaseProvider),
  )..loadCached(),
);
