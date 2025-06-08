import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repo;
  SignUpUseCase(this.repo);
  Future<UserEntity> call(
      String name, String phone, String email, String pass) {
    return repo.signUp(name, phone, email, pass);
  }
}
