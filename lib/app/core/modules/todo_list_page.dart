import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {
  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  const TodoListPage({
    required WidgetBuilder page,
    List<SingleChildWidget>? bindings,
    Key? key,
  })  : _bindings = bindings,
        _page = page,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ?? [Provider(create: (context) => Object())],
      child: Builder(builder: (context) => _page(context)),
    );
  }
}
