import 'dart:io';

import '../../models/list_posts.dart';
import '../../models/post.dart';

abstract class PostDataSource {
  Future<void> deletePost(int id);

  Future<Post> getPost(int id);

  Future<Post> patchPost(int id, String? content, String? image);

  Future<ListPosts> getPosts(int page, int perPage);

  Future<void> createPost(String content, File? image);

  Future<ListPosts> getUserPosts(int id, int page, int perPage);
}
