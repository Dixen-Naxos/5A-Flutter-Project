import 'package:cinqa_flutter_project/models/list_posts.dart';

import '../../../models/post.dart';
import '../../../models/user_posts.dart';
import '../../datasources/post_datasource.dart';
import '../api.dart';

class PostApi extends PostDataSource {
  @override
  Future<void> createPost(String content, String? image) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.post('/post', data: {
        "content": content,
        "image": image,
      });
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.delete('/post/$id');
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
      final response = await Api.dio.get('/post');
      return ListPosts.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Post> patchPost(int id, String? content, String? image) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
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
      final response = await Api.dio.get('/user/$id/posts', data: {
        "page": page,
        "perPage": perPage
      });
      return ListPosts.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
