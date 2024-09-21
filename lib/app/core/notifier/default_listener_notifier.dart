import '../ui/loader.dart';
import '../ui/messages.dart';
import 'default_change_notifier.dart';

final class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  const DefaultListenerNotifier({required this.changeNotifier});

  void listener({
    SuccesVoidCallback? successCallback,
    ErrorVoidCallback? errorCallback,
    EverVoidCallback? everCallback,
  }) =>
      changeNotifier.addListener(() {
        if (everCallback != null) {
          everCallback(changeNotifier, this);
        }

        if (changeNotifier.loading) {
          Loader.show();
        } else {
          Loader.hide();
        }

        if (changeNotifier.hasError) {
          if (errorCallback != null) {
            errorCallback(changeNotifier, this);
          }
          showError(message: changeNotifier.error ?? 'Erro interno');
        } else if (changeNotifier.isSuccess && successCallback != null) {
          successCallback(changeNotifier, this);
        }
      });
}

typedef SuccesVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);

typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);

typedef EverVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);
