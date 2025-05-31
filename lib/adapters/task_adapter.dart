import '../app/models/task_model.dart';

extension type const TaskAdapter._(TaskModel _) implements TaskModel {
  static TaskModel fromMap(Map<String, dynamic> map) => TaskModel(
    id: map['id'] as int,
    description: map['descricao'] as String,
    dateTime: DateTime.parse(map['data_hora'] as String),
    finished: map['finalizado'] == 1,
  );
}
