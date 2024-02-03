import 'package:cinqa_flutter_project/datasources/datasources/user_datasource.dart';
import 'package:cinqa_flutter_project/models/user.dart';

import '../api.dart';

class UserApi extends UserDataSource {
  @override
  Future<User> getUser(int id) async {
    try {
      final response = await Api.dio.get('/user/$id');
      return User(
        id: response.data["id"],
        createdAt: response.data["created_at"],
        name: response.data["name"],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getUserPosts(int id, int page, int perPage) {
    // TODO: implement getUserPosts
    throw UnimplementedError();
  }
}
