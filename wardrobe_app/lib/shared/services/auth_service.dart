import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Authentication service handling all auth providers
class AuthService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService(this._auth);

  /// Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Current user
  User? get currentUser => _auth.currentUser;

  /// Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    return await _auth.signInWithCredential(credential);
  }

  /// Sign in with Facebook
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status != LoginStatus.success) {
      throw Exception('Facebook sign in failed: ${loginResult.message}');
    }

    // Create a credential from the access token
    final OAuthCredential credential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );

    // Sign in to Firebase with the credential
    return await _auth.signInWithCredential(credential);
  }

  /// Sign in with Apple
  Future<UserCredential> signInWithApple() async {
    // Request credential for Apple ID
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create an OAuth credential
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in to Firebase with the credential
    final userCredential = await _auth.signInWithCredential(oauthCredential);

    // Update display name if available (Apple only provides this on first sign-in)
    if (appleCredential.givenName != null || appleCredential.familyName != null) {
      final name = [
        appleCredential.givenName,
        appleCredential.familyName,
      ].where((e) => e != null).join(' ');

      if (name.isNotEmpty) {
        await userCredential.user?.updateDisplayName(name);
      }
    }

    return userCredential;
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    // Create user account
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update display name
    await userCredential.user?.updateDisplayName(name);

    // Send email verification
    await userCredential.user?.sendEmailVerification();

    return userCredential;
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /// Sign out from all providers
  Future<void> signOut() async {
    // Sign out from Google
    await _googleSignIn.signOut();

    // Sign out from Facebook
    await FacebookAuth.instance.logOut();

    // Sign out from Firebase
    await _auth.signOut();
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    await currentUser?.delete();
  }

  /// Update user display name
  Future<void> updateDisplayName(String name) async {
    await currentUser?.updateDisplayName(name);
  }

  /// Update user photo URL
  Future<void> updatePhotoURL(String url) async {
    await currentUser?.updatePhotoURL(url);
  }
}
