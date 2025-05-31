import '../../../adapters/task_adapter.dart';
import '../../core/database/sqlite_connection_factory.dart';
import '../../models/task_model.dart';
import 'task_repository.dart';

final class TaskRepositoryImpl implements TaskRepository {
  final SqliteConnectionFactory connection;

  const TaskRepositoryImpl({required this.connection});

  @override
  Future<void> saveTask({
    required DateTime date,
    required String description,
  }) async {
    final conn = await connection.openConnection();
    await conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod({
    required DateTime start,
    required DateTime end,
  }) async {
    final startFilter = DateTime(start.year, start.month, start.day);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await connection.openConnection();
    final result = await conn.rawQuery(
      '''
 SELECT * 
      from todo
       WHERE data_hora BETWEEN ? AND ? 
       ORDER BY data_hora ''',
      [startFilter.toIso8601String(), endFilter.toIso8601String()],
    );

    return result.map(TaskAdapter.fromMap).toList();
  }

  @override
  Future<void> checkOrUncheckTask({required TaskModel task}) async {
    final conn = await connection.openConnection();
    final finished = task.finished ? 1 : 0;
    await conn.rawUpdate('UPDATE todo SET finalizado = ? WHERE id = ?', [
      finished,
      task.id,
    ]);
  }

  @override
  Future<void> deleteTaskById({required int id}) async {
    final conn = await connection.openConnection();
    await conn.rawDelete('DELETE FROM todo WHERE id = ? ', [id]);
  }
}
