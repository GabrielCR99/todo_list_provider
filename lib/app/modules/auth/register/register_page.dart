import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../core/widgets/todo_list_field.dart';
import '../../../core/widgets/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To Do List',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    label: 'E-mail',
                    controller: emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório!'),
                      Validatorless.email('E-mail inválido!'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: 'Senha',
                    obscureText: true,
                    controller: passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória!'),
                      Validatorless.min(6, 'Senha deve conter 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TodoListField(
                    label: 'Confirmar senha',
                    obscureText: true,
                    controller: confirmPasswordEC,
                    validator: Validatorless.compare(
                      passwordEC,
                      'Senhas devem ser iguais!',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
