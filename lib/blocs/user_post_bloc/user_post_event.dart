part of 'user_post_bloc.dart';

@immutable
abstract class UserPostEvent {}

class GetUserPosts extends UserPostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetUserPosts(
      {required this.userId, required this.page, required this.perPage});
}

class GetMoreUserPosts extends UserPostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetMoreUserPosts(
      {required this.userId, required this.page, required this.perPage});
}

class GetPosts extends UserPostEvent {
  final int page;
  final int perPage;

  GetPosts({required this.page, required this.perPage});
}

class GetMorePosts extends UserPostEvent {
  final int page;
  final int perPage;

  GetMorePosts({required this.page, required this.perPage});
}

class UserDeletePost extends UserPostEvent {
  final Post post;

  UserDeletePost({
    required this.post,
  });
}

class UserPatchPost extends UserPostEvent {
  final Post post;

  UserPatchPost({
    required this.post,
  });
}
