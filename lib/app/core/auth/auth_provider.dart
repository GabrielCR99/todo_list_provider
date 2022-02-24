import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../services/user/user_service.dart';
import '../navigator/app_navigator.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  final UserService _service;

  AuthProvider({required FirebaseAuth auth, required UserService service})
      : _auth = auth,
        _service = service;

  Future<void> logout() async => await _service.logout();

  User? get user => _auth.currentUser;

  void loadListener() {
    _auth.userChanges().listen((_) => notifyListeners());
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        AppNavigator.to.pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        AppNavigator.to.pushNamedAndRemoveUntil('/login', (_) => false);
      }
    });
  }
}
