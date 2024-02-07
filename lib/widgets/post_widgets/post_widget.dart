import 'package:cinqa_flutter_project/widgets/pages/post_detail_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/user_page.dart';
import 'package:flutter/material.dart';

import '../../models/post.dart';
import '../../models/user.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.post, this.user});

  final Post post;

  final User? user;

  @override
  Widget build(BuildContext context) {
    User? realUser = user ?? post.author;
    print(post.id);
    final timeSincePost = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(post.createdAt));
    return GestureDetector(
      onTap: () => _onPostTap(context),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _onProfileTap(context, realUser!.id),
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
                      onTap: () => _onProfileTap(context, realUser!.id),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            realUser!.name,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                              timeSincePost.inDays > 0
                                  ? "${timeSincePost.inDays}j"
                                  : "${timeSincePost.inHours}h",
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
                      child: Text(
                        post.content,
                      ),
                    ),
                  ),
                  if (post.image != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 200, maxWidth: 200),
                        child: Image.network(post.image!.url),
                      ),
                    ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.comment,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ),
                      Text(
                        "${post.commentCounts == 0 || post.commentCounts == null ? "Aucun commentaire" : post.commentCounts}",
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPostTap(BuildContext context) {
    PostDetailPage.navigateTo(context, post.id);
  }

  void _onProfileTap(BuildContext context, int userId) {
    if (user == null) UserPage.navigateTo(context, userId);
  }
}
