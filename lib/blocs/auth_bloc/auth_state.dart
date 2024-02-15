part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
  disconnected,
  connected,
}

class AuthState {
  final User? user;
  final AuthStatus status;
  final DioException? error;

  const AuthState({
    this.user,
    this.status = AuthStatus.initial,
    this.error,
  });

  AuthState copyWith({User? user, AuthStatus? status, DioException? error}) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
