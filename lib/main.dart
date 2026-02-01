import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/task_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/screens/home_screen.dart';

void main() {
  final expNotifier = ExpNotifier();
  final taskNotifier = TaskNotifier();
  final attributeNotifier = AttributeNotifier();

  final gameMaster = GameMaster(
    expNotifier: expNotifier,
    taskNotifier: taskNotifier,
    attributeNotifier: attributeNotifier,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: expNotifier),
        ChangeNotifierProvider.value(value: taskNotifier),
        ChangeNotifierProvider.value(value: attributeNotifier),
        Provider<GameMaster>.value(value: gameMaster),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
