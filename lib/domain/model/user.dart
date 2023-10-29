class User {
  final String login;
  final String password;

  User({required this.login, required this.password});

  Map<String, dynamic> toJson() => {'login': login, 'password': password};
}
