import 'package:cinqa_flutter_project/models/comment.dart';
import 'package:cinqa_flutter_project/widgets/comment_widgets/comment_widget.dart';
import 'package:flutter/material.dart';

import '../global_widgets/separator_widget.dart';

class CommentsListWidget extends StatelessWidget {
  const CommentsListWidget({
    super.key,
    required this.scrollController,
    required this.comments,
    required this.onRefresh,
  });

  final ScrollController scrollController;
  final List<Comment> comments;
  final Future<void> Function() onRefresh;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
          controller: scrollController,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return CommentWidget(
              comment: comments[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SeparatorWidget(id: index);
          },
        ),
      ),
    );
  }
}
