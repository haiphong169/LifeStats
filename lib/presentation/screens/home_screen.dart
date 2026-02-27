import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/character_class_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/inventory_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/arc_progress_painter.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/attribute_display.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/habit_list_tile.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/user_action_button.dart';
import 'package:rpg_self_improvement_app/utils/navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight / 2,
                child: Consumer4<
                  ExpNotifier,
                  AttributeNotifier,
                  CharacterClassNotifier,
                  InventoryNotifier
                >(
                  builder:
                      (
                        context,
                        expNotifier,
                        attributeNotifier,
                        characterClassNotifier,
                        inventoryNotifier,
                        child,
                      ) => Column(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Row(
                              children: [
                                // user actions
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      UserActionButton(
                                        iconImageUrl:
                                            'assets/images/user_action_icons/shop_icon.png',
                                        label: 'Shop',
                                        onPressed:
                                            () => navigateToRoute(
                                              NavigationRoute.shop,
                                              context,
                                            ),
                                      ),
                                      UserActionButton(
                                        iconImageUrl:
                                            'assets/images/user_action_icons/inventory_icon.png',
                                        label: 'Inventory',
                                        onPressed:
                                            () => navigateToRoute(
                                              NavigationRoute.inventory,
                                              context,
                                            ),
                                      ),
                                      UserActionButton(
                                        iconImageUrl:
                                            'assets/images/user_action_icons/change_class_icon.png',
                                        label: 'Change Class',
                                        onPressed:
                                            () => navigateToRoute(
                                              NavigationRoute.classSelection,
                                              context,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                // class portrait, user experience, gold
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/gold_icon.png',
                                            height: 30,
                                          ),
                                          SizedBox(width: 4),
                                          Text("${inventoryNotifier.gold}"),
                                          Spacer(),
                                          IconButton(
                                            onPressed:
                                                () => navigateToRoute(
                                                  NavigationRoute.addTask,
                                                  context,
                                                ),
                                            icon: Icon(Icons.add),
                                            iconSize: 30,
                                          ),
                                        ],
                                      ),
                                      Text("Level ${expNotifier.level}"),
                                      Text(
                                        "${expNotifier.currentXp}/${expNotifier.xpForNextLevel}",
                                      ),
                                      SizedBox(height: 16),
                                      characterClassNotifier.characterClass ==
                                              null
                                          ? CircularProgressIndicator()
                                          : Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomPaint(
                                                size: Size(140, 140),
                                                painter: ArcProgressPainter(
                                                  progress:
                                                      expNotifier.progress,
                                                ),
                                              ),
                                              Image.asset(
                                                characterClassNotifier
                                                    .characterClass!
                                                    .classImage,
                                                height: 120,
                                              ),
                                            ],
                                          ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // attribute displays
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    AttributeDisplay(
                                      attribute:
                                          attributeNotifier
                                              .gameAttributes[AttributeType
                                              .strength],
                                    ),
                                    Spacer(),
                                    AttributeDisplay(
                                      attribute:
                                          attributeNotifier
                                              .gameAttributes[AttributeType
                                              .intelligence],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AttributeDisplay(
                                      attribute:
                                          attributeNotifier
                                              .gameAttributes[AttributeType
                                              .luck],
                                    ),
                                    Spacer(),
                                    AttributeDisplay(
                                      attribute:
                                          attributeNotifier
                                              .gameAttributes[AttributeType
                                              .charisma],
                                    ),
                                  ],
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
                          onDeleteHabit: () {
                            final result = context
                                .read<GameMaster>()
                                .deleteHabit(habit.id);
                            if (!result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Must be an incompleted habit.",
                                  ),
                                ),
                              );
                            }
                          },
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
      ),
    );
  }
}
