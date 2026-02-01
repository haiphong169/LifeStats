import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/task_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/attribute_display.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/experience_bar.dart';
import 'package:rpg_self_improvement_app/presentation/widgets/task_list_tile.dart';
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
            onPressed: () {
              navigateToRoute(NavigationRoute.taskArchive, context);
            },
            icon: Icon(Icons.storage),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToRoute(NavigationRoute.addTask, context),
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer2<ExpNotifier, AttributeNotifier>(
              builder:
                  (context, expNotifier, attributeNotifier, child) => SizedBox(
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
                              SizedBox(height: 15),
                              AnimatedExperienceBar(
                                progress: expNotifier.progress,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
            Expanded(
              child: Consumer<TaskNotifier>(
                builder: (context, value, child) {
                  final uncompletedTasks = value.uncompletedTasks;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final task = uncompletedTasks[index];
                      return TaskListTile(
                        key: Key(task.id),
                        task: task,
                        onCheck: (_) {
                          context.read<GameMaster>().completeTask(
                            task.id,
                            task.attributeType,
                          );
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
    );
  }
}
