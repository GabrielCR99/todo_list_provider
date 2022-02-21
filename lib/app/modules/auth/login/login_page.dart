import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import '../../../core/widgets/todo_list_field.dart';
import '../../../core/widgets/todo_list_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      const TodoListLogo(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              TodoListField(
                                label: 'Email',
                              ),
                              const SizedBox(height: 20),
                              TodoListField(
                                label: 'Senha',
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    child: const Text('Esqueceu sua senha? '),
                                    onPressed: () {},
                                  ),
                                  ElevatedButton(
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Login'),
                                    ),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F3F7),
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: Colors.grey.withAlpha(50),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              SignInButton(
                                Buttons.Google,
                                text: 'Continue com o Google',
                                onPressed: () {},
                                shape: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide.none,
                                ),
                                padding: const EdgeInsets.all(5),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Não tem conta? '),
                                  TextButton(
                                    child: const Text('Cadastre-se!'),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed('/register'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
