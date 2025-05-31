import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/task_model.dart';
import '../home_controller.dart';

final class Task extends StatelessWidget {
  final TaskModel model;

  static final _dateFormat = DateFormat('dd/MM/y');

  const Task({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    final TaskModel(:dateTime, :description, :finished) = model;
    final HomeController(:deleteTask, :checkOrUncheckTask) = context
        .read<HomeController>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              onPressed: (_) => deleteTask(task: model),
              icon: Icons.delete,
              spacing: 0,
              label: 'Deletar',
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ],
        ),
        child: ListTile(
          leading: Checkbox(
            value: finished,
            onChanged: (_) => checkOrUncheckTask(task: model),
          ),
          title: Text(
            _dateFormat.format(dateTime),
            style: TextStyle(
              decoration: finished ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              decoration: finished ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
