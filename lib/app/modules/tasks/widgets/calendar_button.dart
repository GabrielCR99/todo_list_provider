import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../create_task_controller.dart';

final class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDatePicker(context),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.today, color: Colors.grey),
            const SizedBox(width: 10),
            Selector<CreateTaskController, DateTime?>(
              builder: (_, selectedDate, __) => selectedDate != null
                  ? Text(
                      _dateFormat.format(selectedDate),
                      style: context.titleStyle,
                    )
                  : Text('SELECIONE UMA DATA', style: context.titleStyle),
              selector: (_, controller) => controller.selectedDate,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final controller = context.read<CreateTaskController>();

    final lastDate = DateTime.now().add(const Duration(days: 10 * 365));
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: lastDate,
      currentDate: controller.selectedDate,
    );

    if (selectedDate != null) {
      controller.selectedDate = selectedDate;
    }
  }
}
