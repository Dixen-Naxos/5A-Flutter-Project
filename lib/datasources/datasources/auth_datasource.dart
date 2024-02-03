import '../../models/token.dart';
import '../../models/user.dart';

abstract class AuthDataSource {
  Future<Token> login(String email, String password);
  Future<User> me();
  Future<Token> signUp(String name, String email, String password);
}
