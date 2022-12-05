import '../../models/task_model.dart';
import '../../models/week_task_model.dart';
import '../../repositories/tasks/task_repository.dart';
import 'task_service.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepository _repository;

  const TaskServiceImpl({required TaskRepository repository})
      : _repository = repository;

  @override
  Future<void> createTask({
    required DateTime date,
    required String description,
  }) =>
      _repository.saveTask(date: date, description: description);

  @override
  Future<List<TaskModel>> getToday() =>
      _repository.findByPeriod(start: DateTime.now(), end: DateTime.now());

  @override
  Future<List<TaskModel>> getTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    return _repository.findByPeriod(start: tomorrow, end: tomorrow);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: startFilter.weekday - 1));
    }

    endFilter = startFilter.add(const Duration(days: 7));

    final tasks =
        await _repository.findByPeriod(start: startFilter, end: endFilter);

    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }

  @override
  Future<void> checkOrUncheckTask({required TaskModel task}) =>
      _repository.checkOrUncheckTask(task: task);

  @override
  Future<void> deleteTaskById({required int id}) =>
      _repository.deleteTaskById(id: id);
}
