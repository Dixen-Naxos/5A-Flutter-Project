import '../../models/comment.dart';
import '../datasources/comment_datasource.dart';

class CommentRepository {
  final CommentDataSource commentDataSource;

  const CommentRepository({
    required this.commentDataSource,
  });

  Future<void> deleteComment(int id) async {
    return commentDataSource.deleteComment(id);
  }

  Future<Comment> patchComment(int id, String content) async {
    return commentDataSource.patchComment(id, content);
  }

  Future<Comment> createComment(String content, int postId) async {
    return commentDataSource.createComment(content, postId);
  }
}
