import 'package:cinqa_flutter_project/models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../datasources/comment_datasource.dart';
import '../api.dart';

class CommentApi extends CommentDataSource {
  @override
  Future<void> createComment(String content) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      await Api.dio.patch('/comment', data: {
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
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      await Api.dio.delete('/comment/$id');
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comment> patchComment(int id, String content) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      final response = await Api.dio.patch('/comment/$id', data: {
        "content": content,
      });
      return Comment.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
