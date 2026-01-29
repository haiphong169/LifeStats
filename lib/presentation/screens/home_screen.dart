import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/task_notifier.dart';
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
            Consumer<ExpNotifier>(
              builder:
                  (context, value, child) => SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Center(
                      child: Column(
                        children: [
                          Text("Level ${value.level}"),
                          Text("${value.currentXp}/${value.xpForNextLevel}"),
                          SizedBox(height: 15),
                          AnimatedExperienceBar(progress: value.progress),
                        ],
                      ),
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
                          value.checkTask(task.id);
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
