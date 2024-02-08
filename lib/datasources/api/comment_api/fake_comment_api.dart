import 'package:cinqa_flutter_project/models/comment.dart';

import '../../datasources/comment_datasource.dart';

class FakeCommentApi extends CommentDataSource {
  @override
  Future<Comment> createComment(String content, int postId) async {
    try {
      final Map<String, dynamic> response = {
        "id": 1,
        "created_at": 4,
        "content": "Ceci est un commentaire",
        "author": {
          "name": "Dixen",
          "id": 1,
          "created_at": 4,
          "email": "dixen@example.com",
        }
      };
      return Comment.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(int id) async {
    try {
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comment> patchComment(int id, String content) async {
    try {
      final Map<String, dynamic> response = {
        "id": 1,
        "created_at": 4,
        "content": "Ceci est un commentaire",
        "author": {
          "name": "Dixen",
          "id": 1,
          "created_at": 4,
          "email": "dixen@example.com",
        }
      };
      return Comment.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
