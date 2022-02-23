abstract class TaskService {
  Future<void> createTask({
    required DateTime date,
    required String description,
  });
}
