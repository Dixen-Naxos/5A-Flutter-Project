part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class PostComment extends CommentEvent {
  final String content;
  final Post post;

  PostComment({
    required this.content,
    required this.post,
  });
}

class PatchComment extends CommentEvent {
  final String content;
  final Comment comment;

  PatchComment({
    required this.content,
    required this.comment,
  });
}

class DeleteComment extends CommentEvent {
  final Comment comment;

  DeleteComment({
    required this.comment,
  });
}
