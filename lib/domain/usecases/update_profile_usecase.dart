import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repo;
  UpdateProfileUseCase(this.repo);
  Future<void> call(String name, String phone) {
    return repo.updateProfile(name, phone);
  }
}
