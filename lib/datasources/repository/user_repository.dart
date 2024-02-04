import 'package:cinqa_flutter_project/datasources/datasources/user_datasource.dart';

import '../../models/user.dart';
import '../../models/user_posts.dart';

class UserRepository {
  final UserDataSource userDataSource;

  const UserRepository({
    required this.userDataSource,
  });

  Future<UserPosts> getUserPosts(int id, int page, int perPage) async {
    return userDataSource.getUserPosts(id, page, perPage);
  }

  Future<User> getUser(int id) async {
    return userDataSource.getUser(id);
  }
}