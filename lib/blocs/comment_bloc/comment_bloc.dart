import 'package:bloc/bloc.dart';
import 'package:cinqa_flutter_project/datasources/repository/comment_repository.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../models/comment.dart';
import '../../models/post.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc({required this.commentRepository}) : super(const CommentState()) {
    on<PostComment>(_onPost);
    on<PatchComment>(_onPatch);
    on<DeleteComment>(_onDelete);
  }

  void _onPost(PostComment event, emit) async {
    emit(
      state.copyWith(status: CommentStatus.loading),
    );

    try {
      final result = await commentRepository.createComment(
        event.content,
        event.post.id,
      );
      emit(
        state.copyWith(comment: result, status: CommentStatus.created),
      );
    } catch (e) {
      final dioException = e as DioException;
      emit(
        state.copyWith(
          status: CommentStatus.error,
          error: dioException,
        ),
      );
    }
  }

  void _onPatch(PatchComment event, emit) async {
    emit(
      state.copyWith(status: CommentStatus.loading),
    );

    try {
      final result = await commentRepository.patchComment(
        event.comment.id,
        event.content,
      );
      result.author = event.comment.author;
      emit(
        state.copyWith(comment: result, status: CommentStatus.patched),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CommentStatus.error),
      );
    }
  }

  void _onDelete(DeleteComment event, emit) async {
    emit(
      state.copyWith(status: CommentStatus.loading),
    );

    try {
      await commentRepository.deleteComment(
        event.comment.id,
      );
      emit(
        state.copyWith(comment: event.comment, status: CommentStatus.deleted),
      );
    } catch (e) {
      emit(
        state.copyWith(status: CommentStatus.error),
      );
    }
  }
}
