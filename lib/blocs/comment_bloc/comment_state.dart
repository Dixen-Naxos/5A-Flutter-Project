part of 'comment_bloc.dart';

enum CommentStatus {
  initial,
  loading,
  created,
  patched,
  deleted,
  error,
}

class CommentState {
  final Comment? comment;
  final CommentStatus status;
  final DioException? error;

  const CommentState(
      {this.comment, this.status = CommentStatus.initial, this.error});

  CommentState copyWith({
    Comment? comment,
    CommentStatus? status,
    DioException? error,
  }) {
    return CommentState(
        comment: comment ?? this.comment,
        status: status ?? this.status,
        error: error ?? this.error);
  }
}
