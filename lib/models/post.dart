import 'package:cinqa_flutter_project/models/comment.dart';
import 'package:cinqa_flutter_project/models/image.dart';
import 'package:cinqa_flutter_project/models/user.dart';

class Post {
  final int id;
  final int createdAt;
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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      createdAt: json["created_at"],
      content: json["content"],
      author: json["author"] ? User.fromJson(json["author"]) : null,
      userId: json["user_id"],
      comments:
          json["comments"] ? Comment.listFromJson(json["comments"]) : null,
      commentCounts: json["comment_counts"],
      image: json["image"] ? Image.fromJson(json["image"]) : null,
    );
  }

  static List<Post> listFromJson(List<Map<String, dynamic>> list) {
    return list.map((item) => Post.fromJson(item)).toList();
  }
}
