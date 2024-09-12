import 'package:flutter/foundation.dart';
import 'package:meald/models/user.dart';

class UserViewModel with ChangeNotifier {
  int _id = 0;
  String _name = 'azert';
  String _email = '';
  String _password = '';
  String _role = '';

  int get getId => _id;
  String get getName => _name;
  String get getEmail => _email;
  String get getPassword => _password;
  String get getRole => _role;

  set setId(int id) {
    _id = id;
    notifyListeners();
  }

  set setName(String name) {
    _name = name;
    notifyListeners();
  }

  set setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  set setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  set setRole(String role) {
    _role = role;
    notifyListeners();
  }

  void updateFromUser(User user) {
    _id = user.id;
    _name = user.name;
    _email = user.email;
    _password = user.password;
    _role = user.role;
    notifyListeners();
  }
}
