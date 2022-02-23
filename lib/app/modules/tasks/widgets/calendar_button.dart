import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../create_task_controller.dart';

class CalendarButton extends StatelessWidget {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      onTap: () async {
        final lastDate = DateTime.now().add(const Duration(days: 10 * 365));
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate,
        );
        context.read<CreateTaskController>().selectedDate = selectedDate;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.today, color: Colors.grey),
            const SizedBox(width: 10),
            Selector<CreateTaskController, DateTime?>(
              selector: (context, controller) => controller.selectedDate,
              builder: (context, selectedDate, child) => selectedDate != null
                  ? Text(
                      _dateFormat.format(selectedDate),
                      style: context.titleStyle,
                    )
                  : Text(
                      'SELECIONE UMA DATA',
                      style: context.titleStyle,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
