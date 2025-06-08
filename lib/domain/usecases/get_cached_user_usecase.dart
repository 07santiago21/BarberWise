import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository repo;
  GetCachedUserUseCase(this.repo);

  Future<UserEntity?> call() {
    return repo.getCachedUser();
  }
}
