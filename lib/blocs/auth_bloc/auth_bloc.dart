import 'package:bloc/bloc.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<SignUp>(_onSigUp);
    on<LogIn>(_onLogIn);
    on<Me>(_onMe);
    on<Disconnect>(_onDisconnect);
    on<Connect>(_onConnect);
    on<Init>(_onInit);
  }

  void _onSigUp(event, emit) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );

    try {
      final result =
          await authRepository.signUp(event.name, event.email, event.password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.token);
      emit(
        state.copyWith(user: result.user, status: AuthStatus.connect),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error),
      );
    }
  }

  void _onLogIn(event, emit) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );

    try {
      final result = await authRepository.login(event.email, event.password);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.token);
      emit(
        state.copyWith(user: result.user, status: AuthStatus.connect),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error),
      );
    }
  }

  void _onMe(event, emit) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );

    try {
      final result = await authRepository.me();
      emit(
        state.copyWith(user: result, status: AuthStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error),
      );
    }
  }

  void _onDisconnect(event, emit) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('token')) {
        prefs.remove('token');
      }
      emit(
        state.copyWith(status: AuthStatus.disconnected),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.error),
      );
      rethrow;
    }
  }

  void _onConnect(event, emit) async {
    emit(
      state.copyWith(status: AuthStatus.loading),
    );

    try {
      final result = await authRepository.me();
      emit(
        state.copyWith(user: result, status: AuthStatus.connect),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.initial),
      );
    }
  }

  void _onInit(event, emit) async {
    emit(const AuthState(status: AuthStatus.initial));
  }
}
