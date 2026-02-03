import 'package:intl/intl.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';

class HabitMapper {
  Habit fromHabitDto(HabitDto dto) {
    var isCompleted = false;

    // logic quyết định đã sang ngày mới chưa
    var timestamp = dto.lastCompletedTimestamp;
    if (timestamp != null) {
      final lastCompletedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final dateFormatter = DateFormat('dd/MM/yyyy');
      print(dateFormatter.format(lastCompletedDate));
      print(dateFormatter.format(now));
      if (dateFormatter.format(lastCompletedDate) ==
          dateFormatter.format(now)) {
        print("hey");
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
}
