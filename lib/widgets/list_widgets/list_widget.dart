import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../models/user.dart';
import '../post_widgets/post_widget.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.scrollController,
    required this.posts,
    required this.onScroll,
    this.user,
  });

  final ScrollController scrollController;
  final List<Post> posts;
  final VoidCallback onScroll;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
        }, separatorBuilder: (BuildContext context, int index) {
          return const Divider();
      },

      ),
    );
  }
}
