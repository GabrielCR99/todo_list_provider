import '../../../core/notifier/default_change_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_service.dart';

final class RegisterController extends DefaultChangeNotifier {
  final UserService _service;

  RegisterController({required UserService service}) : _service = service;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _service.register(email: email, password: password);

      if (user != null) {
        success();
      } else {
        error = 'Erro ao registrar usuário';
      }
      notifyListeners();
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
