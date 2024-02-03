import '../../models/post.dart';

abstract class PostDataSource {
  Future<void> deletePost(int id);
  Future<Post> getPost(int id);
  Future<Post> patchPost(int id, String? content, String? image);
  Future<List<Post>> getPosts(int page, int perPage);
  Future<void> createPost(String content, String? image);
}