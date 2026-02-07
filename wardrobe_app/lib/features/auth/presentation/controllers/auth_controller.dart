import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email.dart';

class AuthController extends StateNotifier<AsyncValue<UserEntity?>> {
  final AuthRepository _repository;
  final SignInWithGoogle _signInWithGoogle;
  final SignInWithEmail _signInWithEmail;
  final SignUpWithEmail _signUpWithEmail;
  final SignOut _signOut;

  AuthController(
    this._repository,
    this._signInWithGoogle,
    this._signInWithEmail,
    this._signUpWithEmail,
    this._signOut,
  ) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _repository.authStateChanges.listen(
      (user) {
        if (mounted) {
          state = AsyncValue.data(user);
        }
      },
      onError: (error, stack) {
        if (mounted) {
          state = AsyncValue.error(error, stack);
        }
      },
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _signInWithGoogle();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _signInWithEmail(email, password);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _signUpWithEmail(email: email, password: password, name: name);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    // We don't necessarily need to set loading here as authStateChanges will trigger update
    try {
      await _signOut();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Facebook and Apple sign in to be added similarly with their UseCases if needed
}
