import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_dto.dart';

/// Remote Data Source for Authentication.
/// Handles direct interaction with Firebase Auth and Firestore.
abstract class AuthRemoteDataSource {
  Stream<UserDto?> get authStateChanges;
  UserDto? get currentUser;
  Future<UserDto> signInWithGoogle();
  Future<UserDto> signInWithFacebook();
  Future<UserDto> signInWithApple();
  Future<UserDto> signInWithEmail(String email, String password);
  Future<UserDto> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });
  Future<void> signOut();
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRemoteDataSourceImpl({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<UserDto?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return await _getUserDto(firebaseUser);
    });
  }

  @override
  UserDto? get currentUser {
    final user = _auth.currentUser;
    // Note: This is synchronous, so we can't fetch Firestore data here easily without async.
    // However, the interface demands a return value.
    // For synchronous access, we might only check ID, but for full DTO we need async.
    // Given the architecture, UseCases are Future-based, but Repository has a getter.
    // Refactoring: The repository getter for currentUser might be misleading if we need Firestore data.
    // For now, we returns a partial DTO constructed from FirebaseAuth user if possible,
    // or arguably we should change the repository to be async or Stream only.
    // But strict adherence means passing what we have.
    if (user == null) return null;
    return UserDto(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  Future<UserDto> _getUserDto(User firebaseUser) async {
    final doc = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    if (doc.exists) {
      return UserDto.fromFirestore(doc);
    }
    // If user exists in Auth but not Firestore (edge case), return basic info
    return UserDto(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      name: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
    );
  }

  Future<void> _saveUserToFirestore(User user) async {
    final userDto = UserDto(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _firestore
        .collection('users')
        .doc(user.uid)
        .set(userDto.toFirestore(), SetOptions(merge: true));
  }

  @override
  Future<UserDto> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign in cancelled');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user!;
    await _saveUserToFirestore(user);
    return _getUserDto(user);
  }

  @override
  Future<UserDto> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if (loginResult.status != LoginStatus.success) {
      throw Exception('Facebook sign in failed: ${loginResult.message}');
    }
    final OAuthCredential credential = FacebookAuthProvider.credential(
      loginResult.accessToken!.tokenString,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user!;
    await _saveUserToFirestore(user);
    return _getUserDto(user);
  }

  @override
  Future<UserDto> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    final userCredential = await _auth.signInWithCredential(oauthCredential);
    final user = userCredential.user!;

    if (appleCredential.givenName != null ||
        appleCredential.familyName != null) {
      final name = [
        appleCredential.givenName,
        appleCredential.familyName,
      ].where((e) => e != null).join(' ');
      if (name.isNotEmpty) await user.updateDisplayName(name);
    }
    await _saveUserToFirestore(user);
    return _getUserDto(user);
  }

  @override
  Future<UserDto> signInWithEmail(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user!;
    // Firestore sync happens on sign up usually, but good to check/update on login too?
    // Staying consistent with previous logic, usually only read.
    return _getUserDto(user);
  }

  @override
  Future<UserDto> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user!;
    await user.updateDisplayName(name);
    await user.sendEmailVerification();
    await _saveUserToFirestore(user);
    return _getUserDto(user);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).delete();
      await user.delete();
    }
  }
}
