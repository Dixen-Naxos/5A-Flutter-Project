import '../../../models/post.dart';
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
      return Post(
        id: response.data["id"],
        createdAt: response.data["created_at"],
        content: response.data["content"],
        author: response.data["author"],
        comments: response.data["comments"],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Post>> getPosts(int page, int perPage) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Post> patchPost(int id, String? content, String? image) async {
    try {
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.patch('/post/$id', data: {
        "content": content,
        "image": image,
      });
      return Post(
        id: response.data["id"],
        createdAt: response.data["created_at"],
        content: response.data["content"],
        author: response.data["author"],
        comments: response.data["comments"],
      );
    } catch (e) {
      rethrow;
    }
  }
}
