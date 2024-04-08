import 'package:asuka/asuka.dart';
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

final class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

final class _AppWidgetState extends State<AppWidget> {
  final _sqliteAdmin = SqliteAdminConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_sqliteAdmin);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      home: const SplashPage(),
      routes: {
        ...AuthModule().routes,
        ...HomeModule().routes,
        ...TaskModule().routes,
      },
      builder: Asuka.builder,
      title: 'To Do List Provider',
      theme: theme,
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_sqliteAdmin);
    super.dispose();
  }
}
