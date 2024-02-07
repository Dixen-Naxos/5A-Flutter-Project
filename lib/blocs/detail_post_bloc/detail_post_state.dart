part of 'detail_post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class DetailPostState {
  final Post? post;
  final PostStatus status;

  DetailPostState({
    this.post,
    this.status = PostStatus.initial,
  });

  DetailPostState copyWith({
    Post? post,
    PostStatus? status,
  }) {
    return DetailPostState(
      post: post ?? this.post,
      status: status ?? this.status,
    );
  }
}
