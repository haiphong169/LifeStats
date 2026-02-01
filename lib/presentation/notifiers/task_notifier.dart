import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/task.dart';

class TaskNotifier with ChangeNotifier {
  final List<Task> _tasks = [];

  TaskNotifier();

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<Task> get uncompletedTasks =>
      UnmodifiableListView(_tasks.where((task) => !task.isCompleted));

  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((task) => task.isCompleted));

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void checkTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;

    final oldTask = _tasks[index];
    _tasks[index] = oldTask.completedTask();

    notifyListeners();
  }
}
