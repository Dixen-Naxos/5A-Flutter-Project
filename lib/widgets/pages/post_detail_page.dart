import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.postId});

  final int postId;
  static const String routeName = "/postDetailPage";

  static void navigateTo(BuildContext context, int postId) {
    Navigator.of(context).pushNamed(routeName, arguments: postId);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
