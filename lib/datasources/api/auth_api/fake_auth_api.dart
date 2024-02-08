import '../../../models/token.dart';
import '../../../models/user.dart';
import '../../datasources/auth_datasource.dart';

class FakeAuthApi extends AuthDataSource {
  @override
  Future<Token> login(String email, String password) async {
    try {
      final Map<String, dynamic> response = {
        "authToken": "token",
        "user": {
          "name": "Dixen",
          "id": 1,
          "created_at": 4,
          "email": "dixen@example.com",
        }
      };
      return Token(
        token: response["authToken"],
        user: User.fromJson(response["user"]),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> me() async {
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

  @override
  Future<Token> signUp(String name, String email, String password) async {
    try {
      final Map<String, dynamic> response = {
        "authToken": "token",
        "user": {
          "name": "Dixen",
          "id": 1,
          "created_at": 4,
          "email": "dixen@example.com",
        }
      };
      return Token(
        token: response["authToken"],
        user: User.fromJson(response["user"]),
      );
    } catch (e) {
      rethrow;
    }
  }
}
