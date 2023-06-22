import 'package:flutter/cupertino.dart';

sealed class AppNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const AppNavigator._();

  static NavigatorState get to => navigatorKey.currentState!;
}
