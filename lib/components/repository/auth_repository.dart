import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/components/exception/auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.toString());
    } catch (e) {
      throw AuthException('Ошибка подключения. Проверьте интернет-соединение.');
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'LOGIN EXCEPTION');
      throw AuthException(e.toString());
    } catch (e) {
      log(e.toString(), name: 'LOGIN EXCEPTION');
      throw AuthException('Ошибка подключения. Проверьте интернет-соединение.');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credentials = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      final user = await _firebaseAuth.signInWithCredential(credentials);
      return user;
    } catch (e) {
      log(e.toString());
      throw FirebaseAuthException(code: e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      await _firebaseAuth.signOut();
      log('User logged out successfully', name: 'AUTH REPOSITORY');
    } on Exception catch (e) {
      log('Logout failed: $e', name: 'AUTH REPOSITORY');
      rethrow;
    }
  }
}
