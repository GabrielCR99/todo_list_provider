import 'package:flutter/cupertino.dart';

class AppNavigator {
  AppNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState get to => navigatorKey.currentState!;
}
