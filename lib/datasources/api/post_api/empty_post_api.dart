import 'dart:io';

import '../../../models/list_posts.dart';
import '../../../models/post.dart';
import '../../datasources/post_datasource.dart';

class EmptyPostApi extends PostDataSource {
  @override
  Future<void> deletePost(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    throw UnimplementedError();
  }

  @override
  Future<Post> getPost(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    throw UnimplementedError();
  }

  @override
  Future<ListPosts> getUserPosts(int id, int page, int perPage) async {
    await Future.delayed(const Duration(seconds: 3));
    return ListPosts(
      itemsReceived: 0,
      curPage: 0,
      nextPage: null,
      prevPage: null,
      offset: 15,
      itemsTotal: 0,
      pageTotal: 0,
      items: [],
    );
  }

  @override
  Future<Post> patchPost(int id, String? content, File? image) async {
    await Future.delayed(const Duration(seconds: 3));
    throw UnimplementedError();
  }

  @override
  Future<ListPosts> getPosts(int page, int perPage) async {
    await Future.delayed(const Duration(seconds: 3));
    return ListPosts(
      itemsReceived: 0,
      curPage: 0,
      nextPage: null,
      prevPage: null,
      offset: 15,
      itemsTotal: 0,
      pageTotal: 0,
      items: [],
    );
  }

  @override
  Future<void> createPost(String content, File? image) async {
    await Future.delayed(const Duration(seconds: 3));
    throw UnimplementedError();
  }
}
