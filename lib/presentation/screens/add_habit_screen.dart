import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpg_self_improvement_app/domain/game_master.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  AttributeType? _selectedAttributeType;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _generateRandomTitleAndDescription();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // TODO: temporary util method, discard soon
  void _generateRandomTitleAndDescription() {
    final randomInt = Random().nextInt(1000);
    _titleController.text = "Title ${randomInt.toString()}";
    _descriptionController.text = "Description ${randomInt.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Task Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Task Description'),
          ),
          DropdownButton<AttributeType>(
            value: _selectedAttributeType,
            items:
                AttributeType.values
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type.name)),
                    )
                    .toList(),
            onChanged: (AttributeType? newValue) {
              setState(() {
                _selectedAttributeType = newValue;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_selectedAttributeType == null) return;
              final newHabit = Habit(
                id: DateTime.now().toString(),
                title: _titleController.text,
                description: _descriptionController.text,
                isCompleted: false,
                attributeType: _selectedAttributeType!,
              );
              context.read<GameMaster>().addHabit(newHabit);
              Navigator.of(context).pop();
            },
            child: const Text('Add Habit'),
          ),
        ],
      ),
    );
  }
}
