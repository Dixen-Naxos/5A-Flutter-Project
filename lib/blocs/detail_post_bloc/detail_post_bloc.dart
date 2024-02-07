import 'dart:io';

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
    on<Delete>(_onDelete);
    on<CreatePost>(_onPost);
  }

  void _onGetPost(event, emit) async {
    emit(
      state.copyWith(status: DetailPostStatus.loading),
    );

    try {
      final result = await postRepository.getPost(
        event.postId,
      );
      emit(
        state.copyWith(post: result, status: DetailPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }

  void _onDelete(Delete event, emit) async {
    emit(
      state.copyWith(status: DetailPostStatus.loading),
    );

    try {
      await postRepository.deletePost(event.post.id);
      if (event.isInsideDetail) {
        emit(
          state.copyWith(
              post: event.post, status: DetailPostStatus.deletedFromDetail),
        );
      } else {
        emit(
          state.copyWith(
              post: event.post, status: DetailPostStatus.deletedFromList),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }

  void _onPost(CreatePost event, emit) async {
    emit(
      state.copyWith(status: DetailPostStatus.loading),
    );

    try {
      await postRepository.createPost(
        event.content,
        event.image,
      );
      emit(
        state.copyWith(status: DetailPostStatus.success),
      );
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }
}
