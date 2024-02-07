part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetUserPosts extends PostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetUserPosts(
      {required this.userId, required this.page, required this.perPage});
}

class GetMoreUserPosts extends PostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetMoreUserPosts(
      {required this.userId, required this.page, required this.perPage});
}

class GetPosts extends PostEvent {
  final int page;
  final int perPage;

  GetPosts({required this.page, required this.perPage});
}

class GetMorePosts extends PostEvent {
  final int page;
  final int perPage;

  GetMorePosts({required this.page, required this.perPage});
}

class DeletePost extends PostEvent {
  final Post post;

  DeletePost({
    required this.post,
  });
}
