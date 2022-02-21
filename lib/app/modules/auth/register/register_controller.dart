import 'package:flutter/material.dart';

import '../../../exception/auth_exception.dart';
import '../../../services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _service;

  String? error;
  bool success = false;

  RegisterController({required UserService service}) : _service = service;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      error = null;
      success = false;
      notifyListeners();

      final user = await _service.register(email: email, password: password);

      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar usuário';
      }
      notifyListeners();
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
