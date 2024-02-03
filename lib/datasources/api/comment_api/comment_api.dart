import 'package:cinqa_flutter_project/models/comment.dart';

import '../../datasources/comment_datasource.dart';
import '../api.dart';

class CommentApi extends CommentDataSource {
  @override
  Future<void> createComment(String content) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.patch('/comment', data: {
        "content": content,
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(int id) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.delete('/comment/$id');
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comment> patchComment(int id, String content) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.patch('/comment/$id', data: {
        "content": content,
      });
      return Comment(
        id: response.data["id"],
        createdAt: response.data["created_at"],
        content: response.data["content"],
        author: response.data["author"],
      );
    } catch (e) {
      rethrow;
    }
  }
}
