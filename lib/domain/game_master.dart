import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/task_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

class GameMaster {
  final ExpNotifier expNotifier;
  final TaskNotifier taskNotifier;
  final AttributeNotifier attributeNotifier;

  GameMaster({
    required this.expNotifier,
    required this.taskNotifier,
    required this.attributeNotifier,
  });

  void completeTask(String id, AttributeType attributeType) {
    taskNotifier.checkTask(id);
    final didLevelUp = attributeNotifier.gainAttributeExperience(
      5,
      attributeType,
    );

    if (didLevelUp) {
      expNotifier.gainXp(5);
    }
  }
}
