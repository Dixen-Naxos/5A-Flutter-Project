part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error, disconnected, connect }

class AuthState {
  final User? user;
  final AuthStatus status;

  const AuthState({
    this.user,
    this.status = AuthStatus.initial,
  });

  AuthState copyWith({
    User? user,
    AuthStatus? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
