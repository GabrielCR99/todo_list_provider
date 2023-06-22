import 'task_model.dart';

final class WeekTaskModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<TaskModel> tasks;

  const WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}
