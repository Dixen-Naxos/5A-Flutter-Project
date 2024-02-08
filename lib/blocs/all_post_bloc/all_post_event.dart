part of 'all_post_bloc.dart';

@immutable
abstract class AllPostEvent {}

class GetUserPosts extends AllPostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetUserPosts(
      {required this.userId, required this.page, required this.perPage});
}

class GetMoreUserPosts extends AllPostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetMoreUserPosts(
      {required this.userId, required this.page, required this.perPage});
}

class GetPosts extends AllPostEvent {
  final int page;
  final int perPage;

  GetPosts({required this.page, required this.perPage});
}

class GetMorePosts extends AllPostEvent {
  final int page;
  final int perPage;

  GetMorePosts({required this.page, required this.perPage});
}

class AllDeletePost extends AllPostEvent {
  final Post post;

  AllDeletePost({
    required this.post,
  });
}

class AllPatchPost extends AllPostEvent {
  final Post post;

  AllPatchPost({
    required this.post,
  });
}

class AllPostAddCommentCount extends AllPostEvent {
  final Post post;

  AllPostAddCommentCount({
    required this.post,
  });
}

class AllPostSubstractCommentCount extends AllPostEvent {
  final Post post;

  AllPostSubstractCommentCount({
    required this.post,
  });
}
