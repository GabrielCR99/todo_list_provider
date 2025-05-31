import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../models/task_filter_enum.dart';
import '../../../models/total_tasks_model.dart';
import '../home_controller.dart';
import 'card_filter.dart';

final class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FILTROS', style: context.titleStyle),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                selected:
                    context.select<HomeController, TaskFilterEnum>(
                      (value) => value.selectedFilter,
                    ) ==
                    TaskFilterEnum.today,
                totalTasksModel: context
                    .select<HomeController, TotalTasksModel?>(
                      (controller) => controller.todayTotalTasks,
                    ),
              ),
              CardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                selected:
                    context.select<HomeController, TaskFilterEnum>(
                      (value) => value.selectedFilter,
                    ) ==
                    TaskFilterEnum.tomorrow,
                totalTasksModel: context
                    .select<HomeController, TotalTasksModel?>(
                      (controller) => controller.tomorrowTotalTasks,
                    ),
              ),
              CardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                selected:
                    context.select<HomeController, TaskFilterEnum>(
                      (value) => value.selectedFilter,
                    ) ==
                    TaskFilterEnum.week,
                totalTasksModel: context
                    .select<HomeController, TotalTasksModel?>(
                      (controller) => controller.weekTotalTasks,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
