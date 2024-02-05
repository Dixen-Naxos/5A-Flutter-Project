import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/post.dart';
import '../../models/user.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.post, this.user});

  final Post post;

  User? user;

  @override
  Widget build(BuildContext context) {
    user = user ?? post.author;
    final f = DateFormat('dd/MM/yyyy');

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                user!.name,
                style: const TextStyle(fontSize: 25),
              ),
              Text(
                style: const TextStyle(fontSize: 10, color: Colors.grey),
                f.format(DateTime.fromMillisecondsSinceEpoch(post.createdAt)),
              ),
            ],
          ),
          Text(post.content),
          if (post.image != null) Image.network(post.image!.url),
          Text(
            "${post.commentCounts}",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
