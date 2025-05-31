import 'package:flutter/cupertino.dart';
import 'package:provider/single_child_widget.dart';

import 'todo_list_page.dart';

abstract base class TodoListModule {
  final Map<String, WidgetBuilder> _routes;
  final List<SingleChildWidget>? _bindings;

  const TodoListModule({
    required Map<String, WidgetBuilder> routes,
    List<SingleChildWidget>? bindings,
  }) : _routes = routes,
       _bindings = bindings;

  Map<String, WidgetBuilder> get routes => _routes.map(
    (key, pageBuilder) => MapEntry(
      key,
      (_) => TodoListPage(page: pageBuilder, bindings: _bindings),
    ),
  );

  Widget getPage({required String path}) {
    final widgetBuilder = _routes[path];
    if (widgetBuilder != null) {
      return TodoListPage(page: widgetBuilder, bindings: _bindings);
    }

    throw Exception();
  }
}
