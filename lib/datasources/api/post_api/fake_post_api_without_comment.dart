import 'dart:io';

import 'package:cinqa_flutter_project/models/list_posts.dart';

import '../../../models/post.dart';
import '../../datasources/post_datasource.dart';

class FakePostApiWithoutComment extends PostDataSource {
  @override
  Future<void> createPost(String content, File? image) async {
    try {
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      return;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Post> getPost(int id) async {
    await Future.delayed(const Duration(seconds: 5));
    try {
      final Map<String, dynamic> response = {
        "id": 1,
        "created_at": 4,
        "content": "Not patched",
        "author": {
          "name": "Dixen",
          "id": 1,
          "created_at": 4,
        },
        "user_id": 1,
        "comments": [],
        "commentCounts": 0,
        "image": null,
      };
      return Post.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ListPosts> getPosts(int page, int perPage) async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      final Map<String, dynamic> response = {
        "itemsReceived": 1,
        "curPage": 1,
        "nextPage": null,
        "prevPage": null,
        "offset": 1,
        "itemsTotal": 1,
        "pageTotal": 1,
        "items": [
          {
            "id": 1,
            "created_at": 4,
            "content": "Not patched",
            "author": {
              "name": "Dixen",
              "id": 1,
              "created_at": 4,
              "email": "dixen@example.com",
            },
            "user_id": 1,
            "commentCounts": 0,
            "image": null,
          },
        ],
      };
      return ListPosts.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Post> patchPost(int id, String? content, File? image) async {
    try {
      final Map<String, dynamic> response = {
        "id": 1,
        "created_at": 4,
        "content": "Patched",
        "author": {
          "name": "Dixen",
          "id": 1,
          "created_at": 4,
          "email": "dixen@example.com",
        },
        "user_id": 1,
        "comments": [],
        "commentCounts": 0,
        "image": null,
      };
      return Post.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ListPosts> getUserPosts(int id, int page, int perPage) async {
    try {
      final Map<String, dynamic> response = {
        "itemsReceived": 1,
        "curPage": 1,
        "nextPage": null,
        "prevPage": null,
        "offset": 1,
        "itemsTotal": 1,
        "pageTotal": 1,
        "items": [
          {
            "id": 1,
            "created_at": 4,
            "content": "Not patched",
            "author": {
              "name": "Dixen",
              "id": 1,
              "created_at": 4,
              "email": "dixen@example.com",
            },
            "user_id": 1,
            "commentCounts": 0,
            "image": null,
          },
        ],
      };
      return ListPosts.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
