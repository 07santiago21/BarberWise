import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String pass);
  Future<UserEntity> signUp(String email, String pass);
  Future<void> signOut();
  Future<UserEntity?> getCachedUser();
}
