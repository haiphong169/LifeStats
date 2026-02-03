import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';

abstract class HabitRepository {
  Future<void> saveHabit(HabitDto habit);

  Future<HabitDto?> fetchHabitById(String id);

  Future<List<HabitDto>> fetchAllHabits();

  Future<void> updateHabit(HabitDto habit);

  Future<void> deleteHabit(String id);
}
