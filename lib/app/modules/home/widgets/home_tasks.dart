import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_model.dart';
import '../home_controller.dart';
import 'task.dart';

final class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Selector<HomeController, String>(
            builder: (context, value, _) =>
                Text("TASK'S $value", style: context.titleStyle),
            selector: (_, controller) => controller.selectedFilter.description,
          ),
          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                  (controller) => controller.filteredTasks,
                )
                .map((task) => Task(model: task))
                .toList(),
          ),
        ],
      ),
    );
  }
}
