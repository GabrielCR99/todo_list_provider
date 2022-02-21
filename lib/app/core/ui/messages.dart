import 'package:flutter/material.dart';

import 'theme_extensions.dart';

class Messages {
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) => Messages._(context);

  void showError({required String message}) =>
      _showMessage(message: message, color: Colors.red);

  void showInfo({required String message}) =>
      _showMessage(message: message, color: context.primaryColor);

  void _showMessage({required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }
}
