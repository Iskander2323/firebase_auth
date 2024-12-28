import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/components/exception/auth_exception.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      const errorMessages = {
        'email-already-in-use': 'Этот email уже используется.',
        'weak-password': 'Пароль слишком слабый.',
        'invalid-email': 'Некорректный email.',
      };
      final errorMessage = errorMessages[e.code] ??
          'Произошла неизвестная ошибка. Попробуйте снова.';
      throw AuthException(errorMessage);
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
      const errorMessages = {
        'email-already-in-use': 'Этот email уже используется.',
        'weak-password': 'Пароль слишком слабый.',
        'invalid-email': 'Некорректный email.',
      };
      final errorMessage = errorMessages[e.code] ??
          'Произошла неизвестная ошибка. Попробуйте снова.';
      throw AuthException(errorMessage);
    } catch (e) {
      log(e.toString(), name: 'LOGIN EXCEPTION');
      throw AuthException('Ошибка подключения. Проверьте интернет-соединение.');
    }
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
