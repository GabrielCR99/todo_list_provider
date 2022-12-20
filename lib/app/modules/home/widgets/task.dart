import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/task_model.dart';
import '../home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel model;

  static final dateFormat = DateFormat('dd/MM/y');

  const Task({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
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
              icon: Icons.delete,
              spacing: 0,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              label: 'Deletar',
              onPressed: (_) =>
                  context.read<HomeController>().deleteTask(task: model),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
              decoration: model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: model.finished,
            onChanged: (_) =>
                context.read<HomeController>().checkOrUncheckTask(task: model),
          ),
          subtitle: Text(
            model.description,
            style: TextStyle(
              decoration: model.finished ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
