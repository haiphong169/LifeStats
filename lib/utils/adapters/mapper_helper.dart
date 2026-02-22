import 'package:intl/intl.dart';
import 'package:rpg_self_improvement_app/data/dto/attribute_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';

class MapperHelper {
  static Habit fromHabitDto(HabitDto dto) {
    var isCompleted = false;

    // logic quyết định đã sang ngày mới chưa
    var timestamp = dto.lastCompletedTimestamp;
    if (timestamp != null) {
      final lastCompletedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final dateFormatter = DateFormat('dd/MM/yyyy');
      if (dateFormatter.format(lastCompletedDate) ==
          dateFormatter.format(now)) {
        isCompleted = true;
      }
    }

    return Habit(
      id: dto.id,
      description: dto.description,
      title: dto.title,
      attributeType: dto.attributeType,
      isCompleted: isCompleted,
    );
  }

  static Attribute fromAttributeDto(AttributeDto attributeDto) {
    return Attribute(
      level: attributeDto.level,
      currentXp: attributeDto.currentExp,
      attributeType: attributeDto.attributeType,
    );
  }

  static bool isAttributeAssociatedWithCharacterClass(
    CharacterClass characterClass,
    AttributeType attributeType,
  ) {
    return switch (characterClass) {
      CharacterClass.warrior => AttributeType.strength == attributeType,
      CharacterClass.wizard => AttributeType.intelligence == attributeType,
      CharacterClass.merchant => AttributeType.luck == attributeType,
      CharacterClass.lover => AttributeType.charisma == attributeType,
      _ => false,
    };
  }

  static AttributeType? getAssociatedAttributeForCharacterClass(
    CharacterClass characterClass,
  ) {
    return switch (characterClass) {
      CharacterClass.warrior => AttributeType.strength,
      CharacterClass.wizard => AttributeType.intelligence,
      CharacterClass.merchant => AttributeType.luck,
      CharacterClass.lover => AttributeType.charisma,
      _ => null,
    };
  }
}
