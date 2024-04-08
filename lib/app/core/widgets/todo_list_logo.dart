import 'package:flutter/material.dart';

import '../ui/theme_extensions.dart';

final class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png', height: 200),
        Text('To Do List', style: context.textTheme.titleLarge),
      ],
    );
  }
}
