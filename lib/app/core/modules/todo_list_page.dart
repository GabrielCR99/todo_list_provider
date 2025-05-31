import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// The main page widget for the application.
/// This widget is responsible for building the main page of the application
/// and handling the dependency injection using MultiProvider.
final class TodoListPage extends StatelessWidget {
  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  TodoListPage({
    required WidgetBuilder page,
    List<SingleChildWidget>? bindings,
    super.key,
  }) : _bindings = bindings,
       _page = page {
    assert(
      _bindings?.isNotEmpty ?? false || _bindings == null,
      'Bindings must not be empty or null, because MultiProvider does not '
      'accept empty lists. If you do not have any bindings, pass null instead.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bindings != null
        ? MultiProvider(
            providers: _bindings,
            builder: (context, _) => _page(context),
          )
        : _page(context);
  }
}
