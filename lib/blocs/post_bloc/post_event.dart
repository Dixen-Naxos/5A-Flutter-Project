part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetUserPosts extends PostEvent {
  final int userId;
  final int page;
  final int perPage;

  GetUserPosts({
    required this.userId,
    required this.page,
    required this.perPage
  });
}