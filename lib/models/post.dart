import 'package:cinqa_flutter_project/models/image.dart';
import 'package:cinqa_flutter_project/models/comment.dart';
import 'package:cinqa_flutter_project/models/user.dart';

class Post {
  final int id;
  final String createdAt;
  final String content;
  final User? author;
  final int? userId;
  final List<Comment>? comments;
  final int? commentCounts;
  final Image? image;

  Post({
    required this.id,
    required this.createdAt,
    required this.content,
    this.author,
    this.userId,
    this.comments,
    this.commentCounts,
    this.image,
  });
}