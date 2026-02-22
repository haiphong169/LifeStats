import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/screens/add_habit_screen.dart';
import 'package:rpg_self_improvement_app/presentation/screens/character_class_selection_screen.dart';

enum NavigationRoute { home, addTask, settings, classSelection }

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
    case NavigationRoute.classSelection:
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => const CharacterClassSelectionScreen(),
        ),
      );
      break;
  }
}
