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
    throw UnimplementedError();
  }

  @override
  Future<User> me() async {
    // TODO: implement me
    throw UnimplementedError();
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
