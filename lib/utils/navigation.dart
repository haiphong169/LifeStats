import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/screens/add_habit_screen.dart';
import 'package:rpg_self_improvement_app/presentation/screens/character_class_selection_screen.dart';
import 'package:rpg_self_improvement_app/presentation/screens/inventory_screen.dart';
import 'package:rpg_self_improvement_app/presentation/screens/shop_screen.dart';

enum NavigationRoute {
  home,
  addTask,
  settings,
  classSelection,
  shop,
  inventory,
}

void navigateToRoute(NavigationRoute route, BuildContext context) {
  switch (route) {
    case NavigationRoute.home:
      break;
    case NavigationRoute.addTask:
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (context) => const AddHabitScreen()),
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
    case NavigationRoute.shop:
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (context) => const ShopScreen()));
      break;
    case NavigationRoute.inventory:
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (context) => const InventoryScreen()),
      );
  }
}
