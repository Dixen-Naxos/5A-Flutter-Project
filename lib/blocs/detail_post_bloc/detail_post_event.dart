part of 'detail_post_bloc.dart';

@immutable
abstract class DetailPostEvent {}

class GetPost extends DetailPostEvent {
  final int postId;

  GetPost({
    required this.postId,
  });
}

class Delete extends DetailPostEvent {
  final Post post;

  Delete({
    required this.post,
  });
}
