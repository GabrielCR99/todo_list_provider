import 'package:flutter/cupertino.dart';

import '../../core/notifier/default_change_notifier.dart';
import '../../services/tasks/task_service.dart';

class CreateTaskController extends DefaultChangeNotifier {
  final TaskService _service;
  DateTime? _selectedDate;

  CreateTaskController({required TaskService service}) : _service = service;

  set selectedDate(DateTime? date) {
    resetState();
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      if (selectedDate != null) {
        showLoadingAndResetState();
        notifyListeners();
        await _service.createTask(
          date: _selectedDate!,
          description: description,
        );
        success();
      } else {
        setError('Selecione uma data!');
      }
    } on Exception catch (e) {
      setError('Erro ao cadastrar task');
      debugPrint(e.toString());
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
