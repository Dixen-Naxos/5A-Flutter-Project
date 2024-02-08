import 'package:cinqa_flutter_project/widgets/global_widgets/separator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/detail_post_bloc/detail_post_bloc.dart';
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
    return BlocListener<DetailPostBloc, DetailPostState>(
      listener: (context, state) {
        if (state.status == DetailPostStatus.deletedFromDetail) {
          onRefresh();
        }
      },
      child: Expanded(
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
              return SeparatorWidget(id: index);
            },
          ),
        ),
      ),
    );
  }
}
