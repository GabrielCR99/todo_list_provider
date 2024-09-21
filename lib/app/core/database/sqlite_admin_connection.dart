import 'package:flutter/material.dart';

import 'sqlite_connection_factory.dart';

final class SqliteAdminConnection with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final SqliteConnectionFactory(:closeConnection) = SqliteConnectionFactory();

    return switch (state) {
      AppLifecycleState.inactive ||
      AppLifecycleState.paused ||
      AppLifecycleState.detached =>
        closeConnection(),
      _ => null,
    };
  }
}
