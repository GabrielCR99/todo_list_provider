import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import '../../services/user/user_service.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          routes: {
            '/login': (_) => const LoginPage(),
            '/register': (_) => const RegisterPage(),
          },
          bindings: [
            ChangeNotifierProvider(
              create: (context) =>
                  LoginController(service: context.read<UserService>()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  RegisterController(service: context.read<UserService>()),
            ),
          ],
        );
}
