import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';

class LoginState with ChangeNotifier {
  bool _loggedIn = false;
  bool isLoggedIn() => _loggedIn;

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}
