import '../../models/task_model.dart';
import '../../models/week_task_model.dart';
import '../../repositories/tasks/task_repository.dart';
import 'task_service.dart';

final class TaskServiceImpl implements TaskService {
  final TaskRepository repository;

  const TaskServiceImpl({required this.repository});

  @override
  Future<void> createTask({
    required DateTime date,
    required String description,
  }) =>
      repository.saveTask(date: date, description: description);

  @override
  Future<List<TaskModel>> getToday() =>
      repository.findByPeriod(start: DateTime.now(), end: DateTime.now());

  @override
  Future<List<TaskModel>> getTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return repository.findByPeriod(start: tomorrow, end: tomorrow);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final DateTime(:year, :month, :day) = DateTime.now();
    var startFilter = DateTime(year, month, day);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: startFilter.weekday - 1));
    }

    endFilter = startFilter.add(const Duration(days: 7));

    final tasks =
        await repository.findByPeriod(start: startFilter, end: endFilter);

    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }

  @override
  Future<void> checkOrUncheckTask({required TaskModel task}) =>
      repository.checkOrUncheckTask(task: task);

  @override
  Future<void> deleteTaskById({required int id}) =>
      repository.deleteTaskById(id: id);
}
