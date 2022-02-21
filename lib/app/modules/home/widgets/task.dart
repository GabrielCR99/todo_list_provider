import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: const Text(
            'Descrição da task',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          leading: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          subtitle: const Text(
            '21/02/2022',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(),
          ),
        ),
      ),
    );
  }
}
