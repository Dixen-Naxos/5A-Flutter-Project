import 'package:cinqa_flutter_project/models/user.dart';

class Token {
  final String token;
  final User user;

  const Token({
    required this.token,
    required this.user,
  });
}
