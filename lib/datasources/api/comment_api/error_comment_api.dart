import 'package:cinqa_flutter_project/models/comment.dart';

import '../../datasources/comment_datasource.dart';

class ErrorCommentApi extends CommentDataSource {
  @override
  Future<void> createComment(String content) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<void> deleteComment(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<Comment> patchComment(int id, String content) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }
}
