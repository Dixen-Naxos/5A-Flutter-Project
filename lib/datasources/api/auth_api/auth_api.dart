import 'package:dio/dio.dart';

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
      Api.dio.options.headers["Authorization"] = "Bearer token";
      final response = await Api.dio.get('/auth/me');
      return User(
        id: response.data["id"],
        createdAt: response.data["createdAt"],
        name: response.data["name"],
      );
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
