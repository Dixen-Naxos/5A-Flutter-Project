class User {
  final String id;
  final String createdAt;
  final String name;
  final String? email;

  User({
    required this.id,
    required this.createdAt,
    required this.name,
    this.email,
  });
}
