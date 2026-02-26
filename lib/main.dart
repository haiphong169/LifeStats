import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/attribute_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/character_experience_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/item_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/attribute/attribute_repository_local.dart';
import 'package:rpg_self_improvement_app/data/repositories/character_class/character_class_repository_local.dart';
import 'package:rpg_self_improvement_app/data/repositories/character_experience/character_experience_repository_local.dart';
import 'package:rpg_self_improvement_app/data/repositories/habit/habit_repository_local.dart';
import 'package:rpg_self_improvement_app/data/repositories/inventory/inventory_repository_local.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/character_class_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/inventory_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/shop_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/screens/home_screen.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AttributeTypeAdapter());
  Hive.registerAdapter(HabitDtoAdapter());
  Hive.registerAdapter(AttributeDtoAdapter());
  Hive.registerAdapter(CharacterExperienceDtoAdapter());
  Hive.registerAdapter(CharacterClassAdapter());
  Hive.registerAdapter(CharacterClassDtoAdapter());
  Hive.registerAdapter(ItemDtoAdapter());

  final habitRepository = HabitRepositoryLocal();
  final attributeRepository = AttributeRepositoryLocal();
  final characterExperienceRepository = CharacterExperienceRepositoryLocal();
  final characterClassRepository = CharacterClassRepositoryLocal();
  final inventoryRepository = InventoryRepositoryLocal();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final notifier = ExpNotifier(characterExperienceRepository);
            notifier.fetchCharacterExperience();
            return notifier;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final notifier = HabitNotifier(habitRepository);
            notifier.fetchHabits();
            return notifier;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final notifier = AttributeNotifier(attributeRepository);
            notifier.fetchAttributes();
            return notifier;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final notifier = CharacterClassNotifier(characterClassRepository);
            notifier.fetchCharacterClass();
            return notifier;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final notifier = InventoryNotifier(inventoryRepository);
            notifier.loadInventory();
            return notifier;
          },
        ),

        ChangeNotifierProxyProvider<InventoryNotifier, ShopNotifier>(
          create: (_) => ShopNotifier(),
          update: (context, inventoryNotifier, shopNotifier) {
            shopNotifier!.update(inventoryNotifier);
            return shopNotifier;
          },
        ),
        Provider<GameMaster>(
          create:
              (context) => GameMaster(
                expNotifier: context.read<ExpNotifier>(),
                habitNotifier: context.read<HabitNotifier>(),
                attributeNotifier: context.read<AttributeNotifier>(),
                characterClassNotifier: context.read<CharacterClassNotifier>(),
                inventoryNotifier: context.read<InventoryNotifier>(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: HomeScreen(),
    );
  }
}
