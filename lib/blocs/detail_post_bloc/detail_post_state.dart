part of 'detail_post_bloc.dart';

enum DetailPostStatus {
  initial,
  loading,
  success,
  deletedFromList,
  deletedFromDetail,
  updated,
  error,
  patched
}

class DetailPostState {
  final Post? post;
  final DetailPostStatus status;
  final DioException? error;

  DetailPostState({
    this.post,
    this.status = DetailPostStatus.initial,
    this.error,
  });

  DetailPostState copyWith(
      {Post? post, DetailPostStatus? status, DioException? error}) {
    return DetailPostState(
      post: post ?? this.post,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  DetailPostState addComment({
    required Post post,
    required Comment comment,
    DetailPostStatus? status,
  }) {
    post.comments.insert(0, comment);
    return DetailPostState(
      post: post,
      status: status ?? this.status,
    );
  }

  DetailPostState patchComment({
    required Post post,
    required Comment comment,
    DetailPostStatus? status,
  }) {
    for (int i = 0; i < post.comments.length; i++) {
      if (post.comments[i].id == comment.id) {
        post.comments[i] = comment;
      }
    }
    return DetailPostState(
      post: post,
      status: status ?? this.status,
    );
  }

  DetailPostState deleteComment({
    required Post post,
    required Comment comment,
    DetailPostStatus? status,
  }) {
    post.comments.remove(comment);
    return DetailPostState(
      post: post,
      status: status ?? this.status,
    );
  }
}
