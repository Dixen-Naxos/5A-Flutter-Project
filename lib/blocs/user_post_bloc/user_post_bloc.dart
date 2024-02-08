import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasources/repository/post_repository.dart';
import '../../models/list_posts.dart';
import '../../models/post.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  final PostRepository postRepository;

  UserPostBloc({required this.postRepository}) : super(const UserPostState()) {
    on<GetUserPosts>(_onGetUserPosts);
    on<GetMoreUserPosts>(_onGetMoreUserPosts);
    on<GetPosts>(_onGetPosts);
    on<GetMorePosts>(_onGetMorePosts);
    on<UserDeletePost>(_onDelete);
    on<UserPatchPost>(_onPatch);
    on<UserPostAddCommentCount>(_onAddComment);
    on<UserPostSubstractCommentCount>(_onRemoveComment);
  }

  void _onGetUserPosts(event, emit) async {
    emit(
      state.copyWith(status: UserPostStatus.loading),
    );

    try {
      final result = await postRepository.getUserPosts(
        event.userId,
        event.page,
        event.perPage,
      );
      emit(
        state.copyWith(posts: result, status: UserPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetMoreUserPosts(event, emit) async {
    emit(state.lockScrollLoading());
    try {
      final result = await postRepository.getUserPosts(
        event.userId,
        event.page,
        event.perPage,
      );

      emit(
        state.addPosts(posts: result, status: UserPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetPosts(event, emit) async {
    emit(
      state.copyWith(status: UserPostStatus.loading),
    );

    try {
      final result = await postRepository.getPosts(
        event.page,
        event.perPage,
      );
      emit(
        state.copyWith(posts: result, status: UserPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetMorePosts(event, emit) async {
    emit(state.lockScrollLoading());
    try {
      final result = await postRepository.getPosts(
        event.page,
        event.perPage,
      );

      emit(
        state.addPosts(posts: result, status: UserPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onDelete(event, emit) async {
    try {
      emit(
        state.removePosts(post: event.post, status: UserPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onPatch(event, emit) async {
    try {
      emit(
        state.patchPosts(post: event.post, status: UserPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onAddComment(UserPostAddCommentCount event, emit) {
    try {
      emit(
        state.createCommentFromPost(
          post: event.post,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }

  void _onRemoveComment(UserPostSubstractCommentCount event, emit) {
    try {
      emit(
        state.deleteCommentFromPost(
          post: event.post,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: UserPostStatus.error),
      );

      rethrow;
    }
  }
}
