part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LogIn extends AuthEvent {
  final String email;
  final String password;

  LogIn({
    required this.email,
    required this.password,
  });
}

class Me extends AuthEvent {}

class Disconnect extends AuthEvent {}

class Connect extends AuthEvent {}

class Init extends AuthEvent {}
