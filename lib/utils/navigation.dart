import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/screens/add_task_screen.dart';
import 'package:rpg_self_improvement_app/presentation/screens/task_archive_screen.dart';

enum NavigationRoute { home, addTask, settings, taskArchive }

void navigateToRoute(NavigationRoute route, BuildContext context) {
  switch (route) {
    case NavigationRoute.home:
      break;
    case NavigationRoute.addTask:
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (context) => const AddTaskScreen()),
      );
      break;
    case NavigationRoute.settings:
      break;
    case NavigationRoute.taskArchive:
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => const TaskArchiveScreen(),
        ),
      );
      break;
  }
}
