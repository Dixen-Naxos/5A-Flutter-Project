part of 'detail_post_bloc.dart';

enum DetailPostStatus {
  initial,
  loading,
  success,
  deletedFromList,
  deletedFromDetail,
  updated,
  error,
}

class DetailPostState {
  final Post? post;
  final DetailPostStatus status;

  DetailPostState({
    this.post,
    this.status = DetailPostStatus.initial,
  });

  DetailPostState copyWith({
    Post? post,
    DetailPostStatus? status,
  }) {
    return DetailPostState(
      post: post ?? this.post,
      status: status ?? this.status,
    );
  }
}
