import '../../models/comment.dart';

abstract class CommentDataSource {
  Future<void> deleteComment(int id);

  Future<Comment> patchComment(int id, String content);

  Future<Comment> createComment(String content, int postId);
}
