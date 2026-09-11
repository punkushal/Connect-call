class UserModel {
  final String id;
  final String name;
  final String initials;
  final String email;
  final bool isOnline;

  const UserModel({
    required this.id,
    required this.name,
    required this.initials,
    required this.email,
    this.isOnline = false,
  });
}
