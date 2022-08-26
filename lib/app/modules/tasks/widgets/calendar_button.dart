import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../create_task_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      onTap: () async => _showDatePicker(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.today, color: Colors.grey),
            const SizedBox(width: 10),
            Selector<CreateTaskController, DateTime?>(
              selector: (_, controller) => controller.selectedDate,
              builder: (_, selectedDate, __) => selectedDate != null
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
