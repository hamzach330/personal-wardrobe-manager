import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<UserEntity?> get authStateChanges =>
      remoteDataSource.authStateChanges.map((dto) => dto?.toDomain());

  @override
  UserEntity? get currentUser => remoteDataSource.currentUser?.toDomain();

  @override
  Future<UserEntity> signInWithGoogle() async {
    final dto = await remoteDataSource.signInWithGoogle();
    return dto.toDomain();
  }

  @override
  Future<UserEntity> signInWithFacebook() async {
    final dto = await remoteDataSource.signInWithFacebook();
    return dto.toDomain();
  }

  @override
  Future<UserEntity> signInWithApple() async {
    final dto = await remoteDataSource.signInWithApple();
    return dto.toDomain();
  }

  @override
  Future<UserEntity> signInWithEmail(String email, String password) async {
    final dto = await remoteDataSource.signInWithEmail(email, password);
    return dto.toDomain();
  }

  @override
  Future<UserEntity> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final dto = await remoteDataSource.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
    return dto.toDomain();
  }

  @override
  Future<void> signOut() => remoteDataSource.signOut();

  @override
  Future<void> deleteAccount() => remoteDataSource.deleteAccount();
}
