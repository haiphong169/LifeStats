import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/data/dto/habit_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/habit/habit_repository.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/habit.dart';
import 'package:rpg_self_improvement_app/utils/adapters/habit_mapper.dart';

class HabitNotifier with ChangeNotifier {
  final HabitRepository _repository;

  HabitNotifier(this._repository);

  final List<Habit> _habits = [];

  UnmodifiableListView<Habit> get habits => UnmodifiableListView(_habits);

  Future<void> fetchHabits() async {
    final habitDtos = await _repository.fetchAllHabits();
    _habits.clear();
    _habits.addAll(habitDtos.map((habit) => HabitMapper().fromHabitDto(habit)));
    notifyListeners();
  }

  void addHabit(Habit habit) async {
    await _repository.saveHabit(
      HabitDto(
        id: habit.id,
        title: habit.title,
        description: habit.description,
        attributeType: habit.attributeType,
      ),
    );
    _habits.add(habit);
    notifyListeners();
  }

  void deleteHabit(String id) async {
    await _repository.deleteHabit(id);
    _habits.removeWhere((habit) => habit.id == id);
    notifyListeners();
  }

  void checkHabit(String id) async {
    final index = _habits.indexWhere((habit) => habit.id == id);
    if (index == -1) return;

    final oldHabit = _habits[index];
    await _repository.saveHabit(
      HabitDto(
        id: id,
        title: oldHabit.title,
        description: oldHabit.description,
        attributeType: oldHabit.attributeType,
        lastCompletedTimestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    _habits[index] = oldHabit.completedHabit();
    notifyListeners();
  }
}
