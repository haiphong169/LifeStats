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
      child: Container(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Checkbox(value: habit.isCompleted, onChanged: onCheck),
          title: Text(habit.title),
          subtitle: Text(habit.description),
          trailing: Image.asset(
            habit.attributeType.icon,
            height: 50,
            width: 60,
          ),
        ),
      ),
    );
  }
}
