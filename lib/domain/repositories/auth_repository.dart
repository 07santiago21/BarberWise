import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String pass);
  Future<UserEntity> signUp(
      String name, String phone, String email, String pass);
  Future<void> signOut();
  Future<UserEntity?> getCachedUser();
  Future<void> updateProfile(String name, String phone);
  Future<void> changePassword(String newPassword);
}
