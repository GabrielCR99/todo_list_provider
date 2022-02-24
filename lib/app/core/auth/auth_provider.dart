import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../services/user/user_service.dart';
import '../database/sqlite_connection_factory.dart';
import '../navigator/app_navigator.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  final UserService _service;
  final SqliteConnectionFactory _connection;

  AuthProvider({
    required FirebaseAuth auth,
    required UserService service,
    required SqliteConnectionFactory connection,
  })  : _auth = auth,
        _service = service,
        _connection = connection;

  Future<void> logout() async {
    final conn = await _connection.openConnection();
    await conn.rawDelete('''DELETE FROM todo ''');
    await _service.logout();
  }

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
