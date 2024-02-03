import '../../models/user.dart';

abstract class UserDataSource {
  Future<User> getUserPosts(int id, int page, int perPage);
  Future<User> getUser(int id);
}
