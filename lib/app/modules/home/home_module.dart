import 'package:provider/provider.dart';

import '../../core/modules/todo_list_module.dart';
import '../../repositories/tasks/task_repository.dart';
import '../../repositories/tasks/task_repository_impl.dart';
import '../../services/tasks/task_service.dart';
import '../../services/tasks/task_service_impl.dart';
import 'home_controller.dart';
import 'home_page.dart';

final class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          routes: {'/home': (context) => HomePage(controller: context.read())},
          bindings: [
            Provider<TaskRepository>(
              create: (context) =>
                  TaskRepositoryImpl(connection: context.read()),
              lazy: true,
            ),
            Provider<TaskService>(
              create: (context) => TaskServiceImpl(repository: context.read()),
              lazy: true,
            ),
            ChangeNotifierProvider(
              create: (context) => HomeController(service: context.read()),
              lazy: true,
            ),
          ],
        );
}
