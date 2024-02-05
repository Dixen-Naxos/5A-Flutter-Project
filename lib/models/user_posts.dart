import 'package:cinqa_flutter_project/models/post.dart';

class UserPosts {
  final int itemsReceived;
  final int curPage;
  final int? nextPage;
  final int? prevPage;
  final int offset;
  final int itemsTotal;
  final int pageTotal;
  final List<Post> items;

  UserPosts({
    required this.itemsReceived,
    required this.curPage,
    required this.nextPage,
    required this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory UserPosts.fromJson(Map<String, dynamic> json) {
    return UserPosts(
      itemsReceived: json["itemsReceived"],
      curPage: json["curPage"],
      nextPage: json["nextPage"],
      prevPage: json["prevPage"],
      offset: json["offset"],
      itemsTotal: json["itemsTotal"],
      pageTotal: json["pageTotal"],
      items: Post.listFromJson(json["items"] as List<dynamic>),
    );
  }
}
