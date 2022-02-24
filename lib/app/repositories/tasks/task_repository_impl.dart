import '../../core/database/sqlite_connection_factory.dart';
import '../../models/task_model.dart';
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

  @override
  Future<List<TaskModel>> findByPeriod({
    required DateTime start,
    required DateTime end,
  }) async {
    final startFilter = DateTime(start.year, start.month, start.day);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _connection.openConnection();
    final result = await conn.rawQuery(
      ''' SELECT * 
      from todo
       WHERE data_hora BETWEEN ? AND ? 
       ORDER BY data_hora ''',
      [startFilter.toIso8601String(), endFilter.toIso8601String()],
    );

    return result.map((e) => TaskModel.fromMap(e)).toList();
  }

  @override
  Future<void> checkOrUncheckTask({required TaskModel task}) async {
    final conn = await _connection.openConnection();
    final finished = task.finished ? 1 : 0;
    await conn.rawUpdate(
      ''' 
    UPDATE todo 
    SET finalizado = ? 
    WHERE id = ? ''',
      [finished, task.id],
    );
  }

  @override
  Future<void> deleteTask({required TaskModel task}) async {
    final conn = await _connection.openConnection();
    await conn.rawDelete(
      ''' 
        DELETE FROM todo 
        WHERE id = ? ''',
      [task.id],
    );
  }
}
