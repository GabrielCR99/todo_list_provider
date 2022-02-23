import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/database/sqlite_admin_connection.dart';
import 'core/navigator/app_navigator.dart';
import 'core/ui/todo_list_ui_config.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_page.dart';
import 'modules/tasks/task_module.dart';

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
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      navigatorKey: AppNavigator.navigatorKey,
      home: const SplashPage(),
      theme: TodoListUiConfig.theme,
      routes: {
        ...AuthModule().routes,
        ...HomeModule().routes,
        ...TaskModule().routes,
      },
    );
  }
}
