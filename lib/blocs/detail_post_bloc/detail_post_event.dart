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

class PatchPost extends DetailPostEvent {
  final File? image;
  final String content;
  final int id;

  PatchPost({
    required this.image,
    required this.content,
    required this.id,
  });
}

class AddComment extends DetailPostEvent {
  final Comment comment;
  final Post post;

  AddComment({
    required this.comment,
    required this.post,
  });
}

class UpdateComment extends DetailPostEvent {
  final Comment comment;
  final Post post;

  UpdateComment({
    required this.comment,
    required this.post,
  });
}

class RemoveComment extends DetailPostEvent {
  final Comment comment;
  final Post post;

  RemoveComment({
    required this.comment,
    required this.post,
  });
}
