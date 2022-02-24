import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';

class CardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const CardFilter({
    required this.label,
    required this.taskFilter,
    required this.selected,
    this.totalTasksModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        constraints: const BoxConstraints(minHeight: 120, maxWidth: 150),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.8)),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalTasksModel?.totalTasks ?? 0} TASKS',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            TweenAnimationBuilder<double>(
              builder: (_, value, __) => LinearProgressIndicator(
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
                value: value,
                valueColor: AlwaysStoppedAnimation<Color>(
                  selected ? Colors.white : context.primaryColor,
                ),
              ),
              duration: const Duration(seconds: 1),
              tween: Tween(begin: 0.0, end: _getFinishedPercentage()),
            ),
          ],
        ),
      ),
    );
  }

  double _getFinishedPercentage() {
    final total = totalTasksModel?.totalTasks ?? 0.0;
    final doneTotal = totalTasksModel?.totalTasksDones ?? 0.1;

    if (total == 0) {
      return 0.0;
    }

    final percentage = doneTotal * 100 / total;

    return percentage / 100;
  }
}
