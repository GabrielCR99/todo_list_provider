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

class HomePage extends StatefulWidget {
  final HomeController _controller;

  const HomePage({
    required HomeController controller,
    Key? key,
  })  : _controller = controller,
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener(
      context: context,
      successCallback: (_, listener) {
        listener.dispose();
      },
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._controller.loadTotalTasks();
      widget._controller.findTasks(filter: TaskFilterEnum.today);
    });
  }

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
              PopupMenuItem<bool>(
                child: Text(
                  ' ${widget._controller.showFinishedTasks ? 'Esconder' : 'Mostrar'} tarefas concluídas',
                ),
                value: true,
              ),
            ],
            onSelected: (_) => widget._controller.showOrHideFinishedTasks(),
            icon: const Icon(TodoListIcons.filter),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateTask,
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

  Future<void> _goToCreateTask() async {
    await Navigator.of(context).push(
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
    );
    widget._controller.refreshPage();
  }
}
