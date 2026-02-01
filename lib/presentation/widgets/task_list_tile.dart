import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/task.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({super.key, required this.task, required this.onCheck});

  final Task task;
  final void Function(bool?) onCheck;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: task.isCompleted, onChanged: onCheck),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Image.asset(task.attributeType.icon, height: 50, width: 60),
    );
  }
}
