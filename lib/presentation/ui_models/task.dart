import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final AttributeType attributeType;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.attributeType,
  });

  Task completedTask() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: true,
      attributeType: attributeType,
    );
  }
}
