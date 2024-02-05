import 'package:cinqa_flutter_project/datasources/datasources/user_datasource.dart';
import 'package:cinqa_flutter_project/models/user.dart';

import '../api.dart';

class UserApi extends UserDataSource {
  @override
  Future<User> getUser(int id) async {
    try {
      final response = await Api.dio.get('/user/$id');
      return User.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
