import 'package:flutter/material.dart';

abstract base class DefaultChangeNotifier extends ChangeNotifier {
  String? error;
  bool _loading = false;
  bool _success = false;

  bool get loading => _loading;
  bool get hasError => error != null;
  bool get isSuccess => _success;

  void showLoading() => _loading = true;

  void hideLoading() => _loading = false;

  void success() => _success = true;

  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    error = null;
    _success = false;
  }
}
