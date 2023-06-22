import '../../../core/notifier/default_change_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_service.dart';

final class LoginController extends DefaultChangeNotifier {
  String? infoMessage;
  final UserService _service;

  LoginController({required UserService service}) : _service = service;

  bool get hasInfo => infoMessage != null;

  Future<void> login({required String email, required String password}) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _service.login(email: email, password: password);
      if (user != null) {
        success();
      } else {
        error = 'Usuário ou senha inválidos!';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _service.forgotPassword(email: email);
      infoMessage = 'Senha enviada para seu email!';
    } on AuthException catch (e) {
      error = e.message;
    } on Exception {
      error = 'Erro ao resetar a senha!';
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _service.googleLogin();

      if (user != null) {
        success();
      } else {
        _service.logout();
        error = 'Erro ao realizar login pelo google';
      }
    } on AuthException catch (e) {
      _service.logout();
      error = e.message;
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
