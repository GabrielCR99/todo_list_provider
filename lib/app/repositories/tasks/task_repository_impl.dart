import '../../core/database/sqlite_connection_factory.dart';
import './task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SqliteConnectionFactory _connection;

  TaskRepositoryImpl({
    required SqliteConnectionFactory connection,
  }) : _connection = connection;

  @override
  Future<void> saveTask({
    required DateTime date,
    required String description,
  }) async {
    final conn = await _connection.openConnection();
    await Future.delayed(const Duration(seconds: 1));
    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
    });
  }
}
