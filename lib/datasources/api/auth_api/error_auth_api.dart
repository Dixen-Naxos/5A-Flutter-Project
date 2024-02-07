import '../../../models/token.dart';
import '../../../models/user.dart';
import '../../datasources/auth_datasource.dart';

class ErrorAuthApi extends AuthDataSource {
  @override
  Future<Token> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<User> me() async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }

  @override
  Future<Token> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }
}
