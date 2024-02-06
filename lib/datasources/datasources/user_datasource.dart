import '../../models/user.dart';

abstract class UserDataSource {
  Future<User> getUser(int id);
}
