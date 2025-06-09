import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource_impl.dart';
import '../datasources/local_storage_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final SharedPrefsLocalDataSource _local;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required SharedPrefsLocalDataSource local,
  })  : _remote = remote,
        _local = local;

  @override
  Future<UserEntity> signUp(
      String name, String phone, String email, String pass) async {
    final user = await _remote.signUp(name, phone, email, pass);
    await _local.cacheUser(user);
    return user;
  }

  @override
  Future<UserEntity> signIn(String email, String pass) async {
    final user = await _remote.signIn(email, pass);
    await _local.cacheUser(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await _remote.signOut();
    await _local.clearUser();
  }

  @override
  Future<UserEntity?> getCachedUser() {
    return _local.getCachedUser();
  }

  @override
  Future<void> updateProfile(String name, String phone) async {
    await _remote.updateProfile(name, phone);
    final user = await getCachedUser();
    if (user != null) {
      final updated = UserEntity(
        uid: user.uid,
        email: user.email,
        name: name,
        phone: phone,
      );
      await _local.cacheUser(updated);
    }
  }

  @override
  Future<void> changePassword(String newPassword) {
    return _remote.changePassword(newPassword);
  }
}
