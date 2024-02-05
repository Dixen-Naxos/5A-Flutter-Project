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

  const UserState({
    this.user,
    this.status = UserStatus.initial,
  });

  UserState copyWith({
    User? user,
    UserStatus? status,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
