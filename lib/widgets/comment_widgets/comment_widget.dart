import 'package:flutter/material.dart';

import '../../models/comment.dart';
import '../pages/user_page.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final timeSinceComment = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(comment.createdAt));
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _onProfileTap(context, comment.author.id),
              child: const Icon(
                Icons.account_circle,
                color: Colors.black,
                size: 50,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onTap: () => _onProfileTap(context, comment.author.id),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          comment.author.name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            style: const TextStyle(
                                fontSize: 13, color: Colors.grey),
                            timeSinceComment.inDays > 0
                                ? "${timeSinceComment.inDays}j"
                                : "${timeSinceComment.inHours}h",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 75,
                      child: Text(comment.content),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onProfileTap(BuildContext context, int userId) {
    UserPage.navigateTo(context, userId);
  }
}
