import 'package:cinqa_flutter_project/models/post.dart';

class UserPosts {
  final int itemsReceived;
  final int curPage;
  final int nextPage;
  final int prevPage;
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
}
