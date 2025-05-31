import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import 'login/login_controller.dart';
import 'login/login_page.dart';
import 'register/register_controller.dart';
import 'register/register_page.dart';

final class AuthModule extends TodoListModule {
  AuthModule()
    : super(
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
        },
        bindings: [
          ChangeNotifierProvider(
            create: (context) => LoginController(service: context.read()),
            lazy: true,
          ),
          ChangeNotifierProvider(
            create: (context) => RegisterController(service: context.read()),
            lazy: true,
          ),
        ],
      );
}
