import 'dart:io';

import '../../../models/list_posts.dart';
import '../../../models/post.dart';
import '../../datasources/post_datasource.dart';

class ErrorPostApi extends PostDataSource {
  @override
  Future<void> createPost(String content, File? image) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<void> deletePost(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<Post> getPost(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<ListPosts> getPosts(int page, int perPage) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<ListPosts> getUserPosts(int id, int page, int perPage) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<Post> patchPost(int id, String? content, String? image) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }
}
