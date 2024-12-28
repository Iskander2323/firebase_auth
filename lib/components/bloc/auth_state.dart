part of 'auth_bloc.dart';

enum AuthStateStatus { initial, register, success, loading }

final class AuthState extends Equatable {
  const AuthState(
      {this.status = AuthStateStatus.initial,
      this.userCredential,
      this.errorMessage,
      this.isError});

  final AuthStateStatus status;
  final UserCredential? userCredential;
  final String? errorMessage;
  final bool? isError;

  AuthState copyWith(
      {AuthStateStatus? status,
      UserCredential? userCredential,
      String? errorMessage,
      bool? isError}) {
    return AuthState(
        status: status ?? this.status,
        userCredential: userCredential ?? this.userCredential,
        errorMessage: errorMessage ?? this.errorMessage,
        isError: isError ?? this.isError);
  }

  @override
  List<Object?> get props => [status, userCredential, errorMessage, isError];
}
