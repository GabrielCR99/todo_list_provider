import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/navigator/app_navigator.dart';
import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/ui/messages.dart';
import '../../../core/widgets/todo_list_field.dart';
import '../../../core/widgets/todo_list_logo.dart';
import 'login_controller.dart';

part 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      everCallback: (notifier, _) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.showInfo(message: notifier.infoMessage!);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TodoListLogo(),
                    _LoginForm(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F3F7),
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.withAlpha(50),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            SignInButton(
                              Buttons.Google,
                              onPressed: () =>
                                  context.read<LoginController>().googleLogin(),
                              padding: const EdgeInsets.all(5),
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              text: 'Continue com o Google',
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Não tem conta?'),
                                  TextButton(
                                    onPressed: () =>
                                        AppNavigator.to.pushNamed('/register'),
                                    child: const Text('Cadastre-se!'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
