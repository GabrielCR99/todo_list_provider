final class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

  const TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'] as int,
        description: map['descricao'] as String,
        dateTime: DateTime.parse(map['data_hora'] as String),
        finished: map['finalizado'] == 1,
      );

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? finished,
  }) =>
      TaskModel(
        id: id ?? this.id,
        description: description ?? this.description,
        dateTime: dateTime ?? this.dateTime,
        finished: finished ?? this.finished,
      );
}
