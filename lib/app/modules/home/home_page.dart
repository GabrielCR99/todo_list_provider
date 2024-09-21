import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/notifier/default_listener_notifier.dart';
import '../../core/ui/theme_extensions.dart';
import '../../core/ui/todo_list_icons.dart';
import '../../models/task_filter_enum.dart';
import '../tasks/task_module.dart';
import 'home_controller.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_tasks.dart';
import 'widgets/home_week_filter.dart';

final class HomePage extends StatefulWidget {
  final HomeController _controller;

  const HomePage({required HomeController controller, super.key})
      : _controller = controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget
        .._controller.loadTotalTasks()
        .._controller.findTasks(filter: TaskFilterEnum.today),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showOrHideFinishedTasks = widget._controller.showFinishedTasks;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                value: true,
                child: Text(
                  ' ${showOrHideFinishedTasks ? 'Esconder' : 'Mostrar'} '
                  'tarefas concluídas',
                ),
              ),
            ],
            onSelected: (_) => widget._controller.showOrHideFinishedTasks(),
            icon: const Icon(TodoListIcons.filter),
          ),
        ],
        elevation: 0,
        backgroundColor: const Color(0xFFFAFBFE),
        iconTheme: IconThemeData(color: context.primaryColor),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(),
                    HomeFilters(),
                    HomeWeekFilter(),
                    HomeTasks(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: _goToCreateTask,
        child: const Icon(Icons.add),
      ),
      drawer: HomeDrawer(),
      backgroundColor: const Color(0xFFFAFBFE),
    );
  }

  Future<void> _goToCreateTask() async {
    await Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) =>
            TaskModule().routes['/task/create']!(context),
        transitionsBuilder: (_, animation, __, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);

          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
    widget._controller.refreshPage();
  }
}
