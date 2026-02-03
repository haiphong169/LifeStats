import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/screens/add_habit_screen.dart';

enum NavigationRoute { home, addTask, settings }

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
  }
}
