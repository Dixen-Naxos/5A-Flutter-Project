import 'package:cinqa_flutter_project/models/user.dart';

class Comment {
  final int id;
  final int createdAt;
  final String content;
  User? author;

  Comment({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"],
      createdAt: json["created_at"],
      content: json["content"],
      author: json["author"] != null ? User.fromJson(json["author"]) : null,
    );
  }

  static List<Comment> listFromJson(List<dynamic> list) {
    return list
        .map((item) => Comment.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
