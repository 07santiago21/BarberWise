import '../../domain/entities/user_entity.dart';

abstract class LocalStorageDataSource {
  Future<void> cacheUser(UserEntity user);
  Future<UserEntity?> getCachedUser();
  Future<void> clearUser();
}
