import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/ui/theme_extensions.dart';
import '../../../core/widgets/todo_list_field.dart';
import '../../../core/widgets/todo_list_logo.dart';
import 'register_controller.dart';

part 'widgets/register_form.dart';

final class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<RegisterController>())
        .listener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: context.primaryColor.withAlpha(20),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To Do List',
              style: TextStyle(color: context.primaryColor, fontSize: 10),
            ),
            Text(
              'Cadastro',
              style: TextStyle(color: context.primaryColor, fontSize: 15),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.5,
            child:
                const FittedBox(fit: BoxFit.fitHeight, child: TodoListLogo()),
          ),
          _RegisterForm(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
