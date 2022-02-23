abstract class TaskRepository {
  Future<void> saveTask({required DateTime date, required String description});
}
