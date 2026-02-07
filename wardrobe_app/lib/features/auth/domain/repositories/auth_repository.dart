import '../entities/user_entity.dart';

/// Repository interface for authentication operations.
/// Defines the contract that the data layer must implement.
abstract class AuthRepository {
  /// Stream of the current user authentication state.
  /// Emits [UserEntity] when authenticated, or null when not.
  Stream<UserEntity?> get authStateChanges;

  /// The currently authenticated user, or null if not authenticated.
  UserEntity? get currentUser;

  /// Signs in with Google.
  /// Returns the signed-in [UserEntity].
  Future<UserEntity> signInWithGoogle();

  /// Signs in with Facebook.
  /// Returns the signed-in [UserEntity].
  Future<UserEntity> signInWithFacebook();

  /// Signs in with Apple.
  /// Returns the signed-in [UserEntity].
  Future<UserEntity> signInWithApple();

  /// Signs in with email and password.
  /// Returns the signed-in [UserEntity].
  Future<UserEntity> signInWithEmail(String email, String password);

  /// Signs up with email, password, and name.
  /// Returns the signed-up [UserEntity].
  Future<UserEntity> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  /// Signs out the current user.
  Future<void> signOut();

  /// Deletes the current user's account.
  Future<void> deleteAccount();
}
