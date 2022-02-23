import 'package:flutter/material.dart';

import '../../core/ui/theme_extensions.dart';
import '../../core/ui/todo_list_icons.dart';
import '../tasks/task_module.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_tasks.dart';
import 'widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFBFE),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Mostrar tarefas concluídas')),
            ],
            icon: const Icon(TodoListIcons.filter),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, _, child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInQuad);

              return ScaleTransition(
                scale: animation,
                alignment: Alignment.bottomRight,
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                TaskModule().getPage(context, path: '/task/create'),
          ),
        ),
        backgroundColor: context.primaryColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
