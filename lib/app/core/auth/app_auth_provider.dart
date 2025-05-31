import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../services/user/user_service.dart';
import '../database/sqlite_connection_factory.dart';
import '../navigator/app_navigator.dart';
import '../ui/loader.dart';

final class AppAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  final UserService _service;
  final SqliteConnectionFactory _connection;

  AppAuthProvider({
    required FirebaseAuth auth,
    required UserService service,
    required SqliteConnectionFactory connection,
  }) : _auth = auth,
       _service = service,
       _connection = connection;

  Future<void> logout() async {
    Loader.show();
    final conn = await _connection.openConnection();
    await Future.wait([
      conn.rawDelete('''DELETE FROM todo '''),
      _service.logout(),
    ]);

    Loader.hide();
  }

  User? get user => _auth.currentUser;

  void loadListener() => _auth
    ..userChanges().listen((_) => notifyListeners())
    ..authStateChanges().listen(
      (user) => AppNavigator.to.pushNamedAndRemoveUntil(
        user != null ? '/home' : '/login',
        (_) => false,
      ),
    );
}
