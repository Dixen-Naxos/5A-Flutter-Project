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
}
