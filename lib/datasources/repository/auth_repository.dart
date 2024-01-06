import '../../models/token.dart';
import '../../models/user.dart';
import '../datasources/auth_datasource.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  const AuthRepository({
    required this.authDataSource,
  });

  Future<Token> login() async {
    return authDataSource.login();
  }

  Future<User> me() async {
    return authDataSource.me();
  }

  Future<Token> signUp(String name, String email, String password) async {
    return authDataSource.signUp(name, email, password);
  }
}
