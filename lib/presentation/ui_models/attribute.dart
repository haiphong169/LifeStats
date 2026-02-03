import 'package:hive_flutter/hive_flutter.dart';

part 'attribute.g.dart';

@HiveType(typeId: 0)
enum AttributeType {
  @HiveField(0)
  strength,
  @HiveField(1)
  intelligence,
  @HiveField(2)
  luck,
  @HiveField(3)
  charisma,
}

extension AttributeTypeHelper on AttributeType {
  String get icon {
    switch (this) {
      case AttributeType.strength:
        return "assets/images/attribute_icons/strength_icon.png";
      case AttributeType.intelligence:
        return "assets/images/attribute_icons/intelligence_icon.png";
      case AttributeType.luck:
        return "assets/images/attribute_icons/luck_icon.png";
      case AttributeType.charisma:
        return "assets/images/attribute_icons/charisma_icon.png";
    }
  }

  String get name {
    switch (this) {
      case AttributeType.strength:
        return "Strength";
      case AttributeType.intelligence:
        return "Intelligence";
      case AttributeType.luck:
        return "Luck";
      case AttributeType.charisma:
        return "Charisma";
    }
  }
}

class Attribute {
  final int level;
  final int currentXp;
  final int xpForNextLevel;
  final AttributeType attributeType;

  // TODO: Đây là chưa rework hệ thống kinh nghiệm, cần phải sử a sau này
  const Attribute({
    this.level = 1,
    this.currentXp = 0,
    this.xpForNextLevel = 10,
    required this.attributeType,
  });

  double get progress => currentXp / xpForNextLevel;

  (Attribute, bool) gainXp(int xpAmount) {
    int newCurrentXp = currentXp + xpAmount;

    if (newCurrentXp >= xpForNextLevel) {
      int newLevel = level + 1;
      newCurrentXp -= xpForNextLevel;
      int newXpForNextLevel = xpForNextLevel + 10;

      return (
        Attribute(
          level: newLevel,
          currentXp: newCurrentXp,
          xpForNextLevel: newXpForNextLevel,
          attributeType: attributeType,
        ),
        true,
      );
    }

    return (
      Attribute(
        level: level,
        currentXp: newCurrentXp,
        xpForNextLevel: xpForNextLevel,
        attributeType: attributeType,
      ),
      false,
    );
  }
}
