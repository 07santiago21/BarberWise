import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repo;
  SignInUseCase(this.repo);

  Future<UserEntity> call(String email, String pass) {
    return repo.signIn(email, pass);
  }
}
