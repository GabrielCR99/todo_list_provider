import '../../models/task_model.dart';

abstract interface class TaskRepository {
  Future<void> saveTask({required DateTime date, required String description});
  Future<List<TaskModel>> findByPeriod({
    required DateTime start,
    required DateTime end,
  });
  Future<void> checkOrUncheckTask({required TaskModel task});
  Future<void> deleteTaskById({required int id});
}
