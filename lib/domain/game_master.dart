import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/attribute_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/character_class_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/exp_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/habit_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/notifiers/inventory_notifier.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/item.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/item/weapon.dart';
import 'package:rpg_self_improvement_app/utils/adapters/mapper_helper.dart';

class GameMaster {
  final ExpNotifier expNotifier;
  final HabitNotifier habitNotifier;
  final AttributeNotifier attributeNotifier;
  final CharacterClassNotifier characterClassNotifier;
  final InventoryNotifier inventoryNotifier;

  GameMaster({
    required this.expNotifier,
    required this.habitNotifier,
    required this.attributeNotifier,
    required this.characterClassNotifier,
    required this.inventoryNotifier,
  });

  Future<void> completeHabit(String id, AttributeType attributeType) async {
    habitNotifier.checkHabit(id);
    inventoryNotifier.completeHabit();
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
    Weapon? currentWeapon =
        inventoryNotifier.equippedItems.whereType<Weapon>().firstOrNull;
    var weaponExpBonus =
        (currentWeapon == null || currentWeapon.attributeType != attributeType)
            ? 1
            : currentWeapon.attributeBonusExperience;
    int expGain = (baseExpGain * classExpBonus * weaponExpBonus).ceil();
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

  bool deleteHabit(String id) {
    if (habitNotifier.habits
        .firstWhere((habit) => habit.id == id)
        .isCompleted) {
      return false;
    }
    habitNotifier.deleteHabit(id);
    return true;
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

  bool buyItem(Item item) {
    if (item.price > inventoryNotifier.gold) {
      return false;
    }
    inventoryNotifier.buyItem(item);
    return true;
  }
}
