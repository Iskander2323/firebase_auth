part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignUpWithEmailAndPasswordEvent extends AuthEvent {
  const SignUpWithEmailAndPasswordEvent(
      {required this.email, required this.password});
  final String email;
  final String password;
}

final class LoginWithEmailEvent extends AuthEvent {
  const LoginWithEmailEvent({required this.email, required this.password});

  final String email;
  final String password;
}

final class SignUpWithGoogleEvent extends AuthEvent {}

final class LogOutEvent extends AuthEvent {}
