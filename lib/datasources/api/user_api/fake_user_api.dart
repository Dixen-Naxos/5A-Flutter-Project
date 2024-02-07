import '../../../models/user.dart';
import '../../datasources/user_datasource.dart';

class FakeUserApi extends UserDataSource {
  @override
  Future<User> getUser(int id) async {
    try {
      final Map<String, dynamic> response = {
        "name": "Dixen",
        "id": 1,
        "created_at": 4,
        "email": "dixen@example.com",
      };
      return User.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
