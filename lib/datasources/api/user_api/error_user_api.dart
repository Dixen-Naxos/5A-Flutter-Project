import '../../../models/user.dart';
import '../../datasources/user_datasource.dart';

class ErrorUserApi extends UserDataSource {
  @override
  Future<User> getUser(int id) async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }
}
