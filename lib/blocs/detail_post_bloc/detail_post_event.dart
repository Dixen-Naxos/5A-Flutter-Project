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
  final bool isInsideDetail;

  Delete({
    required this.post,
    this.isInsideDetail = false,
  });
}

class CreatePost extends DetailPostEvent {
  final File? image;
  final String content;

  CreatePost({
    required this.image,
    required this.content,
  });
}
