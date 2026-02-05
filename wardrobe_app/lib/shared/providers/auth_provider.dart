import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/user_model.dart';
import '../services/auth_service.dart';

/// Firebase Auth instance provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(firebaseAuthProvider));
});

/// Auth state stream provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

/// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});

/// User model provider (wraps Firebase User into our UserModel)
final userModelProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  
  return UserModel(
    id: user.uid,
    name: user.displayName,
    email: user.email,
    photoUrl: user.photoURL,
    createdAt: user.metadata.creationTime ?? DateTime.now(),
  );
});

/// Auth state notifier for managing auth state
class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen(
      (user) => state = AsyncValue.data(user),
      onError: (error, stack) => state = AsyncValue.error(error, stack),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithGoogle();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signInWithFacebook() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithFacebook();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithApple();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithEmail(email, password);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}

/// Auth state notifier provider
final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
  return AuthStateNotifier(ref.watch(authServiceProvider));
});
