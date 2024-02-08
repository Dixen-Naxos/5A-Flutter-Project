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

  const CommentState({
    this.comment,
    this.status = CommentStatus.initial,
  });

  CommentState copyWith({
    Comment? comment,
    CommentStatus? status,
  }) {
    return CommentState(
      comment: comment ?? this.comment,
      status: status ?? this.status,
    );
  }
}
