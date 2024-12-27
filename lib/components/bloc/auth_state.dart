part of 'auth_bloc.dart';

enum AuthStateStatus { initial, success, loading, error }

final class AuthState extends Equatable {
  const AuthState(
      {this.status = AuthStateStatus.initial,
      this.userCredential,
      this.errorMessage});

  final AuthStateStatus status;
  final UserCredential? userCredential;
  final String? errorMessage;

  AuthState copyWith(
      {AuthStateStatus? status,
      UserCredential? userCredential,
      String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      userCredential: userCredential ?? this.userCredential,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, userCredential, errorMessage];
}
