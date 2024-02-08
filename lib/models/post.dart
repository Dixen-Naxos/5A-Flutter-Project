import 'package:cinqa_flutter_project/models/comment.dart';
import 'package:cinqa_flutter_project/models/image.dart';
import 'package:cinqa_flutter_project/models/user.dart';

class Post {
  final int id;
  final int createdAt;
  final String content;
  User? author;
  final int? userId;
  List<Comment>? comments;
  int? commentCounts;
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
      author: json["author"] != null ? User.fromJson(json["author"]) : null,
      userId: json["user_id"],
      comments: json["comments"] != null
          ? Comment.listFromJson(json["comments"])
          : [],
      commentCounts: json["comments_count"],
      image: json["image"] != null ? Image.fromJson(json["image"]) : null,
    );
  }

  static List<Post> listFromJson(List<dynamic> list) {
    return list
        .map((item) => Post.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'comments': comments,
      'comments_count': commentCounts,
    };
  }
}
