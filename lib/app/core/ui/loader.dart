import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

sealed class Loader {
  static OverlayEntry? _entry;
  static bool _open = false;

  const Loader._();

  static void show() {
    _entry ??= OverlayEntry(
      builder: (_) => const PopScope(
        canPop: false,
        child: ColoredBox(
          color: Colors.black54,
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );

    if (!_open) {
      _open = true;
      Asuka.addOverlay(_entry!);
    }
  }

  static void hide() {
    if (_open) {
      _open = false;
      _entry?.remove();
    }
  }
}
