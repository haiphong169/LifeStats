import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

class GameMaster {
  final ExpNotifier expNotifier;
  final HabitNotifier habitNotifier;
  final AttributeNotifier attributeNotifier;

  GameMaster({
    required this.expNotifier,
    required this.habitNotifier,
    required this.attributeNotifier,
  });

  Future<void> completeHabit(String id, AttributeType attributeType) async {
    habitNotifier.checkHabit(id);
    final didLevelUp = attributeNotifier.gainAttributeExperience(
      5,
      attributeType,
    );

    if (await didLevelUp) {
      expNotifier.gainXp(5);
    }
  }

  void deleteHabit(String id) {
    habitNotifier.deleteHabit(id);
  }
}
