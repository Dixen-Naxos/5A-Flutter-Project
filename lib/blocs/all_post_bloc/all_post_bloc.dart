import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../datasources/repository/post_repository.dart';
import '../../models/list_posts.dart';
import '../../models/post.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final PostRepository postRepository;

  AllPostBloc({required this.postRepository}) : super(const AllPostState()) {
    on<GetUserPosts>(_onGetUserPosts);
    on<GetMoreUserPosts>(_onGetMoreUserPosts);
    on<GetPosts>(_onGetPosts);
    on<GetMorePosts>(_onGetMorePosts);
    on<AllDeletePost>(_onDelete);
    on<AllPatchPost>(_onPatch);
  }

  void _onGetUserPosts(event, emit) async {
    emit(
      state.copyWith(status: AllPostStatus.loading),
    );

    try {
      final result = await postRepository.getUserPosts(
        event.userId,
        event.page,
        event.perPage,
      );
      emit(
        state.copyWith(posts: result, status: AllPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllPostStatus.error),
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
        state.addPosts(posts: result, status: AllPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllPostStatus.error),
      );

      rethrow;
    }
  }

  void _onGetPosts(event, emit) async {
    emit(
      state.copyWith(status: AllPostStatus.loading),
    );

    try {
      final result = await postRepository.getPosts(
        event.page,
        event.perPage,
      );
      emit(
        state.copyWith(posts: result, status: AllPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllPostStatus.error),
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
        state.addPosts(posts: result, status: AllPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllPostStatus.error),
      );

      rethrow;
    }
  }

  void _onDelete(event, emit) async {
    try {
      emit(
        state.removePosts(post: event.post, status: AllPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllPostStatus.error),
      );

      rethrow;
    }
  }

  void _onPatch(event, emit) async {
    try {
      emit(
        state.patchPosts(post: event.post, status: AllPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllPostStatus.error),
      );

      rethrow;
    }
  }
}
