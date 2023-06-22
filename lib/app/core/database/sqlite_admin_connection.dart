import 'package:flutter/material.dart';

import 'sqlite_connection_factory.dart';

final class SqliteAdminConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final connection = SqliteConnectionFactory();

    return switch (state) {
      AppLifecycleState.inactive ||
      AppLifecycleState.paused ||
      AppLifecycleState.detached =>
        connection.closeConnection(),
      _ => null,
    };
  }
}
