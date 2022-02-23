import '../../repositories/tasks/task_repository.dart';
import './task_service.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepository _repository;

  TaskServiceImpl({
    required TaskRepository repository,
  }) : _repository = repository;

  @override
  Future<void> createTask({
    required DateTime date,
    required String description,
  }) async =>
      _repository.saveTask(date: date, description: description);
}
