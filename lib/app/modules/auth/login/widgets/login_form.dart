part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TodoListField(
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocus,
              controller: _emailEC,
              validator: Validatorless.multiple([
                Validatorless.required('E-mail obrigatório!'),
                Validatorless.email('E-mail inválido!'),
              ]),
            ),
            const SizedBox(height: 20),
            TodoListField(
              label: 'Senha',
              obscureText: true,
              controller: _passwordEC,
              validator: Validatorless.multiple([
                Validatorless.required('Senha obrigatória!'),
                Validatorless.min(6, 'Senha deve conter 6 caracteres'),
              ]),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _onPressedForgotPassword,
                  child: const Text('Esqueceu sua senha? '),
                ),
                ElevatedButton(
                  onPressed: _onPressedLogin,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedLogin() {
    FocusScope.of(context).unfocus();
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      context.read<LoginController>().login(
            email: _emailEC.text,
            password: _passwordEC.text,
          );
    }
  }

  void _onPressedForgotPassword() {
    if (_emailEC.text.isNotEmpty) {
      context.read<LoginController>().forgotPassword(
            email: _emailEC.text,
          );
    } else {
      _emailFocus.requestFocus();
      Messages.showError(
        message: 'Digite um E-mail para recuperar a senha',
      );
    }
  }
}
