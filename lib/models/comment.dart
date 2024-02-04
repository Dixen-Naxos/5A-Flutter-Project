import 'package:cinqa_flutter_project/models/user.dart';

class Comment {
  final int id;
  final String createdAt;
  final String content;
  final User author;

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
      author: User.fromJson(json["author"]),
    );
  }

  static List<Comment> listFromJson(List<Map<String, dynamic>> list) {
    return list.map((item) => Comment.fromJson(item)).toList();
  }
}
