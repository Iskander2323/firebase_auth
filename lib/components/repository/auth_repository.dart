import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on Exception catch (e) {
      log(e.toString(), name: 'AUTH REPOSITORY');
    }
    return null;
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on Exception catch (e) {
      log(e.toString(), name: 'AUTH REPOSITORY');
    }
    return null;
  }

  Future<void> signInWithGoogle() async {}

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
      log('User logged out successfully', name: 'AUTH REPOSITORY');
    } on Exception catch (e) {
      log('Logout failed: $e', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }
}
