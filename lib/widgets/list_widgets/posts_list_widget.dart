import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../models/user.dart';
import '../post_widgets/post_widget.dart';

class PostsListWidget extends StatelessWidget {
  const PostsListWidget({
    super.key,
    required this.scrollController,
    required this.posts,
    required this.onScroll,
    required this.onRefresh,
    this.user,
  });

  final ScrollController scrollController;
  final List<Post> posts;
  final VoidCallback onScroll;
  final User? user;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          controller: scrollController,
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            if (index == posts.length) {
              onScroll();
            } else {
              return PostWidget(
                post: posts[index],
                user: user,
              );
            }
            return null;
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
