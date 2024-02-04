import 'package:cinqa_flutter_project/models/user_posts.dart';

import '../../models/user.dart';

abstract class UserDataSource {
  Future<UserPosts> getUserPosts(int id, int page, int perPage);
  Future<User> getUser(int id);
}
