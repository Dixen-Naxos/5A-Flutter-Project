part of 'post_bloc.dart';

enum PostStatus {
  initial,
  loading,
  success,
  error,
}

class PostState {
  final ListPosts? posts;
  final PostStatus status;

  const PostState({
    this.posts,
    this.status = PostStatus.initial,
  });

  PostState copyWith({
    ListPosts? posts,
    PostStatus? status,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }
}