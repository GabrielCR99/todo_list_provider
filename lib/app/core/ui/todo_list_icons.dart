import 'package:flutter/widgets.dart';

sealed class TodoListIcons {
  static const IconData eye = IconData(0xf06e, fontFamily: _kFontFam);
  static const IconData eyeSlash = IconData(0xf070, fontFamily: _kFontFam);
  static const IconData filter = IconData(0xf0b0, fontFamily: _kFontFam);

  static const _kFontFam = 'TodoListIcons';

  const TodoListIcons._();
}
