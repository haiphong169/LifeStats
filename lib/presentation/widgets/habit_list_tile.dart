import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';

class HabitListTile extends StatelessWidget {
  const HabitListTile({
    super.key,
    required this.habit,
    required this.onCheck,
    required this.onDeleteHabit,
  });

  final Habit habit;
  final void Function(bool?) onCheck;
  final void Function() onDeleteHabit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                ElevatedButton(
                  onPressed: () {
                    onDeleteHabit();
                    Navigator.of(context).pop();
                  },
                  child: Text("Delete Habit"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Checkbox(value: habit.isCompleted, onChanged: onCheck),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      habit.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Image.asset(habit.attributeType.icon, height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
