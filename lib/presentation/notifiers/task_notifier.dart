import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/task.dart';

class TaskNotifier with ChangeNotifier {
  final void Function(int) addXp;
  final List<Task> _tasks = [];

  TaskNotifier({required this.addXp});

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
    final checkedTask = _tasks.firstWhere((task) => task.id == id);
    checkedTask.isCompleted = true;
    addXp(5);
    notifyListeners();
  }
}
