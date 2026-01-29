import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/task_notifier.dart';

class TaskArchiveScreen extends StatelessWidget {
  const TaskArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Archive")),
      body: Center(
        child: Consumer<TaskNotifier>(
          builder: (context, value, child) {
            final completedTasks = value.completedTasks;
            return ListView.builder(
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(completedTasks[index].title),
                    subtitle: Text(completedTasks[index].description),
                  ),
              itemCount: completedTasks.length,
            );
          },
        ),
      ),
    );
  }
}
