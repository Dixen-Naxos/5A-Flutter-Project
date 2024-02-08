import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../datasources/repository/post_repository.dart';
import '../../models/comment.dart';
import '../../models/post.dart';

part 'detail_post_event.dart';
part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  final PostRepository postRepository;

  DetailPostBloc({required this.postRepository}) : super(DetailPostState()) {
    on<GetPost>(_onGetPost);
    on<Delete>(_onDelete);
    on<CreatePost>(_onPost);
    on<PatchPost>(_onPatch);
    on<AddComment>(_onAddComment);
    on<UpdateComment>(_onPatchComment);
    on<RemoveComment>(_onDeleteComment);
  }

  void _onGetPost(event, emit) async {
    emit(
      state.copyWith(status: DetailPostStatus.loading),
    );

    try {
      final result = await postRepository.getPost(
        event.postId,
      );
      //print(jsonEncode(result));
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

  void _onPatch(PatchPost event, emit) async {
    emit(
      state.copyWith(status: DetailPostStatus.loading),
    );

    try {
      await postRepository.patchPost(
        event.id,
        event.content,
        event.image,
      );
      final result2 = await postRepository.getPost(
        event.id,
      );
      emit(
        state.copyWith(post: result2, status: DetailPostStatus.patched),
      );
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }

  void _onAddComment(AddComment event, emit) {
    try {
      emit(
        state.addComment(post: event.post, comment: event.comment),
      );
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }

  void _onPatchComment(UpdateComment event, emit) {
    try {
      emit(
        state.patchComment(post: event.post, comment: event.comment),
      );
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }

  void _onDeleteComment(RemoveComment event, emit) {
    try {
      emit(
        state.deleteComment(post: event.post, comment: event.comment),
      );
    } catch (e) {
      emit(
        state.copyWith(status: DetailPostStatus.error),
      );

      rethrow;
    }
  }
}
