import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/character_class_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';
import 'package:rpg_self_improvement_app/utils/adapters/mapper_helper.dart';

class GameMaster {
  final ExpNotifier expNotifier;
  final HabitNotifier habitNotifier;
  final AttributeNotifier attributeNotifier;
  final CharacterClassNotifier characterClassNotifier;

  GameMaster({
    required this.expNotifier,
    required this.habitNotifier,
    required this.attributeNotifier,
    required this.characterClassNotifier,
  });

  Future<void> completeHabit(String id, AttributeType attributeType) async {
    habitNotifier.checkHabit(id);
    var baseExpGain = 5;
    var classExpBonus =
        MapperHelper.isAttributeAssociatedWithCharacterClass(
              characterClassNotifier.characterClass!,
              attributeType,
            )
            ? 1.5
            : characterClassNotifier.characterClass! == CharacterClass.normie
            ? 1
            : 0.8;
    int expGain = (baseExpGain * classExpBonus).ceil();
    final didLevelUp = attributeNotifier.gainAttributeExperience(
      expGain,
      attributeType,
    );

    if (await didLevelUp) {
      expNotifier.gainXp(5);
    }
  }

  void addHabit(Habit habit) {
    int attributeHabitLength =
        habitNotifier.habits
            .where((h) => h.attributeType == habit.attributeType)
            .length;
    int attributeLevel =
        attributeNotifier.gameAttributes[habit.attributeType]!.level;
    int limit = habitLimitForAttributeLevel(attributeLevel);

    if (attributeHabitLength < limit) {
      habitNotifier.addHabit(habit);
    }
  }

  int habitLimitForAttributeLevel(int attributeLevel) =>
      (attributeLevel / 5).ceil();

  void deleteHabit(String id) {
    habitNotifier.deleteHabit(id);
  }

  void selectCharacterClass(CharacterClass characterClass) {
    if (characterClassNotifier.characterClass == CharacterClass.normie) {
      if (characterClass == CharacterClass.normie) {
        characterClassNotifier.saveCharacterClass(characterClass, null);
      } else {
        final associatedAttribute =
            attributeNotifier
                .gameAttributes[MapperHelper.getAssociatedAttributeForCharacterClass(
              characterClass,
            )];
        characterClassNotifier.saveCharacterClass(
          characterClass,
          associatedAttribute!.level,
        );
      }
    } else {
      final hasQualifiedForClassChange =
          characterClassNotifier.lastPickedAtAttributeLevel! + 3 <=
          attributeNotifier
              .gameAttributes[MapperHelper.getAssociatedAttributeForCharacterClass(
                characterClassNotifier.characterClass!,
              )]!
              .level;
      if (hasQualifiedForClassChange) {
        if (characterClass == CharacterClass.normie) {
          characterClassNotifier.saveCharacterClass(characterClass, null);
        } else {
          final associatedAttribute =
              attributeNotifier
                  .gameAttributes[MapperHelper.getAssociatedAttributeForCharacterClass(
                characterClass,
              )];
          characterClassNotifier.saveCharacterClass(
            characterClass,
            associatedAttribute!.level,
          );
        }
      }
    }
  }
}
