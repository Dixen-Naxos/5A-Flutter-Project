import 'package:cinqa_flutter_project/models/comment.dart';
import 'package:cinqa_flutter_project/widgets/comment_widgets/comment_widget.dart';
import 'package:flutter/material.dart';


class CommentsListWidget extends StatelessWidget {
  const CommentsListWidget({
    super.key,
    required this.scrollController,
    required this.comments,
  });

  final ScrollController scrollController;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentWidget(
            comment: comments[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
