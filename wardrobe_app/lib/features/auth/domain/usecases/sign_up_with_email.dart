import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmail {
  final AuthRepository repository;

  SignUpWithEmail(this.repository);

  Future<UserEntity> call({
    required String email,
    required String password,
    required String name,
  }) async {
    return repository.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
  }
}
