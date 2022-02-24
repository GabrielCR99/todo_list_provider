import '../../models/task_model.dart';

abstract class TaskRepository {
  Future<void> saveTask({required DateTime date, required String description});
  Future<List<TaskModel>> findByPeriod({
    required DateTime start,
    required DateTime end,
  });
  Future<void> checkOrUncheckTask({required TaskModel task});
  Future<void> deleteTask({required TaskModel task});
}
