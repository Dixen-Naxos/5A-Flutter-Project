import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasources/repository/post_repository.dart';
import '../../models/post.dart';

part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  final PostRepository postRepository;

  DetailPostBloc({required this.postRepository}) : super(DetailPostState()) {
    on<GetPost>(_onGetPost);
  }

  void _onGetPost(event, emit) async {
    emit(
      state.copyWith(status: PostStatus.loading),
    );

    try {
      final result = await postRepository.getPost(
        event.postId,
      );
      emit(
        state.copyWith(post: result, status: PostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error),
      );

      rethrow;
    }
  }
}
