import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/habit/habit_repository_local.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/screens/home_screen.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AttributeTypeAdapter());
  Hive.registerAdapter(HabitDtoAdapter());

  final habitRepository = HabitRepositoryLocal();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpNotifier()),
        ChangeNotifierProvider(
          create: (_) {
            final notifier = HabitNotifier(habitRepository);
            notifier.fetchHabits();
            return notifier;
          },
        ),
        ChangeNotifierProvider(create: (_) => AttributeNotifier()),
        Provider<GameMaster>(
          create:
              (context) => GameMaster(
                expNotifier: context.read<ExpNotifier>(),
                habitNotifier: context.read<HabitNotifier>(),
                attributeNotifier: context.read<AttributeNotifier>(),
              ),
        ),
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
