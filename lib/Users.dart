class User {
  final String id;
  final String password;
  final String email;

  User({required this.id, required this.password, required this.email});
}

class Users {
  List<User> _users = [];

  Users() {
    loadSavedUsers();
  }

  void addUser(User user) {
    _users.add(user);
  }

  void loadSavedUsers() {
    _users = [
      User(id: "123456", password: "123", email: "teste@teste.com"),
      User(id: "2345678901", password: "535367", email: "jane@example.com"),
    ];
  }

  void clearUsers() {
    _users.clear();
  }

  Future<bool> login(String email, String password) async {
    return _users.any((user) => user.email == email && user.password == password);
  }
}