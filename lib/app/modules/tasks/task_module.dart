import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import '../../repositories/tasks/task_repository.dart';
import '../../repositories/tasks/task_repository_impl.dart';
import '../../services/tasks/task_service.dart';
import '../../services/tasks/task_service_impl.dart';
import 'create_task_controller.dart';
import 'create_task_page.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
          routes: {
            '/task/create': (context) =>
                CreateTaskPage(controller: context.read()),
          },
          bindings: [
            Provider<TaskRepository>(
              create: (context) =>
                  TaskRepositoryImpl(connection: context.read()),
            ),
            Provider<TaskService>(
              create: (context) => TaskServiceImpl(repository: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  CreateTaskController(service: context.read()),
            ),
          ],
        );
}
