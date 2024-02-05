import 'package:bloc/bloc.dart';
import 'package:cinqa_flutter_project/models/user_posts.dart';
import 'package:meta/meta.dart';

import '../../datasources/repository/user_repository.dart';
import '../../models/user.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState()) {
    on<GetUser>(_onGetUser);
  }

  void _onGetUser(event, emit) async {
    emit(
      state.copyWith(status: UserStatus.loading),
    );

    try {
      final result = await userRepository.getUser(event.userId);
      emit(
        state.copyWith(user: result, status: UserStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserStatus.error),
      );

      rethrow;
    }
  }
}
