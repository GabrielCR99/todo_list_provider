import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';

final class CardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const CardFilter({
    required this.label,
    required this.taskFilter,
    required this.selected,
    this.totalTasksModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.8)),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        constraints: const BoxConstraints(maxWidth: 150, minHeight: 120),
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getTasksNotDone(),
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: _getFinishedPercentage()),
              duration: const Duration(seconds: 1),
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  selected ? Colors.white : context.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTasksNotDone() {
    final totalTasks = totalTasksModel?.totalTasks ?? 0;
    final totalTasksDone = totalTasksModel?.totalTasksDones ?? 0;

    return '${totalTasks - totalTasksDone} TASKS';
  }

  double _getFinishedPercentage() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final doneTotal = totalTasksModel?.totalTasksDones ?? 0.1;

    if (total == 0) {
      return 0;
    }

    final percentage = doneTotal * 100 / total;

    return percentage / 100;
  }
}
