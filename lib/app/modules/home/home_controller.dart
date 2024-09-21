import '../../core/notifier/default_change_notifier.dart';
import '../../models/task_filter_enum.dart';
import '../../models/task_model.dart';
import '../../models/total_tasks_model.dart';
import '../../models/week_task_model.dart';
import '../../services/tasks/task_service.dart';

final class HomeController extends DefaultChangeNotifier {
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishedTasks = false;

  TaskFilterEnum selectedFilter = TaskFilterEnum.today;

  final TaskService _service;

  HomeController({required TaskService service}) : _service = service;

  Future<void> loadTotalTasks() async {
    final [
      todayTasks as List<TaskModel>,
      tomorrow as List<TaskModel>,
      weekTasks as WeekTaskModel,
    ] = await Future.wait(
      [_service.getToday(), _service.getTomorrow(), _service.getWeek()],
    );

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksDones: todayTasks.where((element) => element.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrow.length,
      totalTasksDones: tomorrow.where((element) => element.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksDones:
          weekTasks.tasks.where((element) => element.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    selectedFilter = filter;
    showLoading();
    notifyListeners();
    var tasks = <TaskModel>[];

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _service.getToday();
      case TaskFilterEnum.tomorrow:
        tasks = await _service.getTomorrow();
      case TaskFilterEnum.week:
        final WeekTaskModel(:startDate, tasks: weekTotalTasks) =
            await _service.getWeek();
        initialDateOfWeek = startDate;
        tasks = weekTotalTasks;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishedTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks =
        allTasks.where((task) => task.dateTime == selectedDay).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: selectedFilter);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask({required TaskModel task}) async {
    showLoadingAndResetState();
    notifyListeners();
    final updatedTask = task.copyWith(finished: !task.finished);
    await _service.checkOrUncheckTask(task: updatedTask);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishedTasks() {
    showFinishedTasks = !showFinishedTasks;
    refreshPage();
  }

  Future<void> deleteTask({required TaskModel task}) async {
    showLoadingAndResetState();
    notifyListeners();
    await _service.deleteTaskById(id: task.id);
    hideLoading();
    refreshPage();
  }
}
