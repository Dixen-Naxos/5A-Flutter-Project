import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/token.dart';
import '../../../models/user.dart';
import '../../datasources/auth_datasource.dart';
import '../api.dart';

class AuthApi extends AuthDataSource {
  @override
  Future<Token> login(String email, String password) async {
    try {
      final response = await Api.dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });
      return Token(token: response.data["authToken"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> me() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Api.dio.options.headers["Authorization"] =
          "Bearer ${prefs.get(("token"))}";
      final response = await Api.dio.get('/auth/me');
      return User.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Token> signUp(String name, String email, String password) async {
    try {
      final response = await Api.dio.post('/auth/signup', data: {
        "name": name,
        "email": email,
        "password": password,
      });
      return Token(token: response.data["authToken"]);
    } catch (e) {
      rethrow;
    }
  }
}
