import 'package:flutter/cupertino.dart';

abstract class AppNavigator {
  const AppNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}
