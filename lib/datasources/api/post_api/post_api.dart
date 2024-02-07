import 'dart:io';

import 'package:cinqa_flutter_project/models/list_posts.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/post.dart';
import '../../datasources/post_datasource.dart';
import '../api.dart';

class PostApi extends PostDataSource {
  @override
  Future<void> createPost(String content, File? image) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      await Api.dio.post(
        '/post',
        data: FormData.fromMap({
          "content": content,
          "base_64_image":
              image != null ? await MultipartFile.fromFile(image.path) : null,
        }),
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      await Api.dio.delete('/post/$id');
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Post> getPost(int id) async {
    try {
      final response = await Api.dio.get('/post/$id');
      return Post.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ListPosts> getPosts(int page, int perPage) async {
    try {
      final response = await Api.dio.get('/post', queryParameters: {
        "page": page,
        "per_page": perPage,
      });
      return ListPosts.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Post> patchPost(int id, String? content, String? image) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      final response = await Api.dio.patch('/post/$id', data: {
        "content": content,
        "image": image,
      });
      return Post.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ListPosts> getUserPosts(int id, int page, int perPage) async {
    try {
      final response = await Api.dio.get('/user/$id/posts', queryParameters: {
        "page": page,
        "per_page": perPage,
      });
      return ListPosts.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
