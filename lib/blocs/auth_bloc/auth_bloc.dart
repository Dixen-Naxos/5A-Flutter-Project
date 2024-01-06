import 'package:bloc/bloc.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<SignUp>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));

      try {
        await authRepository.signUp(event.name, event.email, event.password);
      } catch (e) {
        rethrow;
      }
    });
  }
}
