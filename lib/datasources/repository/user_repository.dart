import '../../models/user.dart';
import '../datasources/user_datasource.dart';

class UserRepository {
  final UserDataSource userDataSource;

  const UserRepository({
    required this.userDataSource,
  });

  Future<User> getUser(int id) async {
    return userDataSource.getUser(id);
  }
}
