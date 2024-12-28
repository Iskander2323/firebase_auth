import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/components/exception/auth_exception.dart';
import 'package:firebase_auth_app/components/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required authRepository})
      : _authRepository = authRepository,
        super(AuthState()) {
    on<SignUpWithEmailAndPasswordEvent>(_signUpWithEmailAndPassword);
    on<LoginWithEmailEvent>(_loginWithEmail);
    on<SignUpWithGoogleEvent>(_signInWithGoogle);
    on<LogOutEvent>(_logOut);
    on<RegisterNewAccountEvent>(_registerNewAccount);
    on<AlreadyHaveAccountEvent>(_alreadyHaveAccount);
    on<ResetErrorBoolEvent>(_resetErrorBool);
  }

  final AuthRepository _authRepository;

  Future<void> _signUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final userCredential = await _authRepository.signUpWithEmailAndPassword(
          event.email, event.password);
      emit(state.copyWith(
          status: AuthStateStatus.success, userCredential: userCredential));
    } on AuthException catch (e) {
      log(e.toString(), name: 'REGISTER EXCEPTION BLOC');
      emit(state.copyWith(
          isError: true,
          errorMessage: e.message,
          status: AuthStateStatus.register));
    } catch (e) {
      log(e.runtimeType.toString());
      log(e.toString(), name: 'REGISTER EXCEPTION BLOC');
      emit(state.copyWith(
          isError: true,
          errorMessage: e.toString(),
          status: AuthStateStatus.register));
    }
  }

  Future<void> _loginWithEmail(
      LoginWithEmailEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));
      final userCredential = await _authRepository.loginWithEmailAndPassword(
          event.email, event.password);
      emit(state.copyWith(
          status: AuthStateStatus.success, userCredential: userCredential));
    } on AuthException catch (e) {
      log(e.toString(), name: 'LOGIN EXCEPTION BLOC');
      emit(state.copyWith(
          isError: true,
          errorMessage: e.message,
          status: AuthStateStatus.initial));
    } catch (e) {
      log(e.toString(), name: 'LOGIN EXCEPTION BLOC');
      emit(state.copyWith(
          isError: true,
          errorMessage: e.toString(),
          status: AuthStateStatus.initial));
    }
  }

  Future<void> _signInWithGoogle(
      SignUpWithGoogleEvent event, Emitter<AuthState> emit) async {}

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    await _authRepository.logOut();
    emit(state.copyWith(status: AuthStateStatus.initial));
  }

  void _registerNewAccount(
      RegisterNewAccountEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.register));
  }

  void _alreadyHaveAccount(
      AlreadyHaveAccountEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.initial));
  }

  void _resetErrorBool(ResetErrorBoolEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(isError: false));
  }
}
