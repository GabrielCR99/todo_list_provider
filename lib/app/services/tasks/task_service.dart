import '../../models/task_model.dart';
import '../../models/week_task_model.dart';

abstract interface class TaskService {
  Future<void> createTask({
    required DateTime date,
    required String description,
  });
  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskModel> getWeek();
  Future<void> checkOrUncheckTask({required TaskModel task});
  Future<void> deleteTaskById({required int id});
}
