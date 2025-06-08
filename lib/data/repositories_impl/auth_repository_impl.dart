import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/local_storage_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final LocalStorageDataSource local;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<UserEntity> signIn(String email, String pass) async {
    final cred = await remote.signIn(email, pass);
    final user = UserEntity(
      uid: cred.user!.uid,
      email: cred.user!.email!,
    );
    await local.cacheUser(user);
    return user;
  }

  @override
  Future<UserEntity> signUp(String email, String pass) async {
    final cred = await remote.signUp(email, pass);
    final user = UserEntity(
      uid: cred.user!.uid,
      email: cred.user!.email!,
    );
    await local.cacheUser(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await remote.signOut();
    await local.clearUser();
  }

  @override
  Future<UserEntity?> getCachedUser() {
    return local.getCachedUser();
  }
}
