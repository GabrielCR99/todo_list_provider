import 'package:asuka/asuka.dart';

void showError({required String message}) =>
    AsukaSnackbar.alert(message).show();

void showInfo({required String message}) => AsukaSnackbar.info(message).show();
