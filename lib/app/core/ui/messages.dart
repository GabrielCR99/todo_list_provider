import 'package:asuka/asuka.dart';

class Messages {
  const Messages._();

  static void showError({required String message}) =>
      AsukaSnackbar.alert(message).show();

  static void showInfo({required String message}) =>
      AsukaSnackbar.info(message).show();
}
