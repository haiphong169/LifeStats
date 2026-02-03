import 'package:hive/hive.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/habit/habit_repository.dart';

class HabitRepositoryLocal implements HabitRepository {
  static const String _boxName = 'habit_box';

  Future<Box<HabitDto>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<HabitDto>(_boxName);
    }
    return await Hive.openBox<HabitDto>(_boxName);
  }

  @override
  Future<void> saveHabit(HabitDto habit) async {
    final box = await _openBox();
    await box.put(habit.id, habit);
  }

  @override
  Future<void> deleteHabit(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  @override
  Future<HabitDto?> fetchHabitById(String id) {
    // TODO: implement fetchHabitById
    throw UnimplementedError();
  }

  @override
  Future<void> updateHabit(HabitDto habit) async {
    // TODO: implement updateHabit
    throw UnimplementedError();
  }

  @override
  Future<List<HabitDto>> fetchAllHabits() async {
    final box = await _openBox();

    return box.values.toList();
  }
}
