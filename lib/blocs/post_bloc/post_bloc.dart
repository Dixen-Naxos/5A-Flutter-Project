import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasources/repository/post_repository.dart';
import '../../models/list_posts.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<GetUserPosts>(_onGetUserPosts);
    on<GetMoreUserPosts>(_onGetMoreUserPosts);
    on<GetPosts>(_onGetPosts);
    on<GetMorePosts>(_onGetMorePosts);
  }

  void _onGetUserPosts(event, emit) async {
    emit(
      state.copyWith(status: PostStatus.loading),
    );

    try {
      final result = await postRepository.getUserPosts(
        event.userId,
        event.page,
        event.perPage,
      );
      emit(
        state.copyWith(posts: result, status: PostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetMoreUserPosts(event, emit) async {
    try {
      final result = await postRepository.getUserPosts(
        event.userId,
        event.page,
        event.perPage,
      );

      emit(
        state.addPosts(posts: result, status: PostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetPosts(event, emit) async {
    emit(
      state.copyWith(status: PostStatus.loading),
    );

    try {
      final result = await postRepository.getPosts(
        event.page,
        event.perPage,
      );
      emit(
        state.copyWith(posts: result, status: PostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetMorePosts(event, emit) async {
    emit(
      state.copyWith(status: PostStatus.scrollLoading),
    );

    try {
      final result = await postRepository.getPosts(
        event.page,
        event.perPage,
      );

      emit(
        state.addPosts(posts: result, status: PostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.error),
      );

      rethrow;
    }
  }
}
