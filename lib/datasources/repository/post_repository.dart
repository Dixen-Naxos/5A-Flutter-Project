import '../../models/post.dart';
import '../datasources/post_datasource.dart';

class PostRepository {
  final PostDataSource postDataSource;

  const PostRepository({
    required this.postDataSource,
  });

  Future<void> deletePost(int id) async {
    return postDataSource.deletePost(id);
  }

  Future<Post> getPost(int id) async {
    return postDataSource.getPost(id);
  }

  Future<Post> patchPost(int id, String? content, String? image) async {
    return postDataSource.patchPost(id, content, image);
  }

  Future<List<Post>> getPosts(int page, int perPage) async {
    return postDataSource.getPosts(page, perPage);
  }

  Future<void> createPost(String content, String? image) async {
    return postDataSource.createPost(content, image);
  }

}