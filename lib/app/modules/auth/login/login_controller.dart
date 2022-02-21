import '../../../core/notifier/default_change_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _service;
  String? infoMessage;

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
        setError('Usuário ou senha inválidos!');
      }
    } on AuthException catch (e) {
      setError(e.message);
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
      setError(e.message);
    } on Exception {
      setError('Erro ao resetar a senha!');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
