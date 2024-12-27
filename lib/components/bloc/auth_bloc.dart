import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/auth_repository.dart';

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
  }

  final AuthRepository _authRepository;

  Future<void> _signUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    final UserCredential? userCredential = await _authRepository
        .signUpWithEmailAndPassword(event.email, event.password);
    if (userCredential != null) {
      emit(state.copyWith(
          status: AuthStateStatus.success, userCredential: userCredential));
    } else {
      emit(state.copyWith(status: AuthStateStatus.initial));
    }
  }

  Future<void> _loginWithEmail(
      LoginWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
  }

  Future<void> _signInWithGoogle(
      SignUpWithGoogleEvent event, Emitter<AuthState> emit) async {}

  Future<void> _logOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    await _authRepository.logOut();
    emit(state.copyWith(status: AuthStateStatus.initial));
  }
}
