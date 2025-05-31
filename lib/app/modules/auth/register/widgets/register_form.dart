part of '../register_page.dart';

class _RegisterForm extends StatefulWidget {
  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TodoListField(
              label: 'E-mail',
              controller: _emailEC,
              validator: Validatorless.multiple([
                Validatorless.required('E-mail obrigatório!'),
                Validatorless.email('E-mail inválido!'),
              ]),
            ),
            const SizedBox(height: 20),
            TodoListField(
              label: 'Senha',
              controller: _passwordEC,
              obscureText: true,
              validator: Validatorless.multiple([
                Validatorless.required('Senha obrigatória!'),
                Validatorless.min(6, 'Senha deve conter 6 caracteres'),
              ]),
            ),
            const SizedBox(height: 20),
            TodoListField(
              label: 'Confirmar senha',
              controller: _confirmPasswordEC,
              obscureText: true,
              validator: Validatorless.compare(
                _passwordEC,
                'Senhas devem ser iguais!',
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => _onPressedRegister(context),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Salvar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedRegister(BuildContext context) {
    FocusScope.of(context).unfocus();
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      context.read<RegisterController>().register(
        email: _emailEC.text,
        password: _passwordEC.text,
      );
    }
  }
}
