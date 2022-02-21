import 'package:flutter/material.dart';
import 'core/database/sqlite_admin_connection.dart';
import 'core/ui/todo_list_ui_config.dart';
import 'modules/auth/auth_module.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmin = SqliteAdminConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(sqliteAdmin);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(sqliteAdmin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List Provider',
      home: const SplashPage(),
      theme: TodoListUiConfig.theme,
      routes: {
        ...AuthModule().routes,
      },
    );
  }
}
