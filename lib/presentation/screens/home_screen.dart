import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/character_class_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/attribute_display.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/experience_bar.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/habit_list_tile.dart';
import 'package:rpg_self_improvement_app/utils/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LifeStats"),
        actions: [
          IconButton(
            onPressed:
                () => navigateToRoute(NavigationRoute.classSelection, context),
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () => navigateToRoute(NavigationRoute.addTask, context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Consumer3<ExpNotifier, AttributeNotifier, CharacterClassNotifier>(
              builder:
                  (
                    context,
                    expNotifier,
                    attributeNotifier,
                    characterClassNotifier,
                    child,
                  ) => SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 50,
                            children:
                                attributeNotifier.gameAttributes.values
                                    .map(
                                      (attribute) => AttributeDisplay(
                                        attribute: attribute,
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              Text("Level ${expNotifier.level}"),
                              Text(
                                "${expNotifier.currentXp}/${expNotifier.xpForNextLevel}",
                              ),
                              SizedBox(height: 10),
                              AnimatedExperienceBar(
                                progress: expNotifier.progress,
                              ),
                              SizedBox(height: 10),
                              characterClassNotifier.characterClass == null
                                  ? CircularProgressIndicator()
                                  : Image.asset(
                                    characterClassNotifier
                                        .characterClass!
                                        .classImage,
                                    height: 60,
                                    width: 60,
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
            Expanded(
              child: Consumer<HabitNotifier>(
                builder: (context, value, child) {
                  final uncompletedTasks = value.habits;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final habit = uncompletedTasks[index];
                      return HabitListTile(
                        key: Key(habit.id),
                        habit: habit,
                        onCheck: (_) {
                          if (habit.isCompleted) return;
                          context.read<GameMaster>().completeHabit(
                            habit.id,
                            habit.attributeType,
                          );
                        },
                        onDeleteHabit:
                            () => context.read<GameMaster>().deleteHabit(
                              habit.id,
                            ),
                      );
                    },
                    itemCount: uncompletedTasks.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
