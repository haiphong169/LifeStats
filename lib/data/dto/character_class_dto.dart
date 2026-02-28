import 'package:hive_flutter/hive_flutter.dart';

part 'character_class_dto.g.dart';

@HiveType(typeId: 4)
enum CharacterClass {
  @HiveField(0)
  warrior,
  @HiveField(1)
  wizard,
  @HiveField(2)
  merchant,
  @HiveField(3)
  lover,
  @HiveField(4)
  normie,
}

extension CharacterClassHelper on CharacterClass {
  String get classImage {
    switch (this) {
      case CharacterClass.warrior:
        return "assets/images/warrior.png";
      case CharacterClass.wizard:
        return "assets/images/wizard.png";
      case CharacterClass.merchant:
        return "assets/images/merchant.png";
      case CharacterClass.lover:
        return "assets/images/lover.png";
      case CharacterClass.normie:
        return "assets/images/normie.png";
    }
  }

  String get classEffectDescription {
    switch (this) {
      case CharacterClass.warrior:
        return "Bonus 50% XP for Strength habits completion, reduces 20% XP gain from all other habits";
      case CharacterClass.wizard:
        return "Bonus 50% XP for Intelligence habits completion, reduces 20% XP gain from all other habits";
      case CharacterClass.merchant:
        return "Bonus 50% XP for Luck habits completion, reduces 20% XP gain from all other habits";
      case CharacterClass.lover:
        return "Bonus 50% XP for Charisma habits completion, reduces 20% XP gain from all other habits";
      case CharacterClass.normie:
        return "No special bonuses or penalties. Balanced XP gain across all habit types.";
    }
  }
}

@HiveType(typeId: 5)
class CharacterClassDto {
  @HiveField(0)
  final CharacterClass characterClass;

  @HiveField(1)
  final int? lastPickedAtAttributeLevel;

  CharacterClassDto({
    required this.characterClass,
    this.lastPickedAtAttributeLevel,
  });
}
