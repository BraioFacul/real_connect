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
    saveUsers();
  }

  void loadSavedUsers() {
    _users = [
      User(id: "1623456789", password: "1531", email: "john@example.com"),
      User(id: "2345678901", password: "535367", email: "jane@example.com"),
    ];
  }

  void saveUsers() {
    // Implement saving logic if necessary
  }

  void clearUsers() {
    _users.clear();
  }

  Future<bool> login(String email, String password) async {
    return _users.any((user) => user.email == email && user.password == password);
  }
}