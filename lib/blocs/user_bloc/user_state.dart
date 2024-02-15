part of 'user_bloc.dart';

enum UserStatus {
  initial,
  loading,
  success,
  error,
}

class UserState {
  final User? user;
  final UserStatus status;
  final DioException? error;

  const UserState({
    this.user,
    this.status = UserStatus.initial,
    this.error,
  });

  UserState copyWith({
    User? user,
    UserStatus? status,
    DioException? error,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
