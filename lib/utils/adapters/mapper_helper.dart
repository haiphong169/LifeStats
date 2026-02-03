import 'package:intl/intl.dart';
import 'package:rpg_self_improvement_app/data/dto/attribute_dto.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';

class MapperHelper {
  Habit fromHabitDto(HabitDto dto) {
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

  Attribute fromAttributeDto(AttributeDto attributeDto) {
    return Attribute(
      level: attributeDto.level,
      currentXp: attributeDto.currentExp,
      attributeType: attributeDto.attributeType,
    );
  }
}
