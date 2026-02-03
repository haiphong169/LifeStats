import 'package:hive/hive.dart';
import 'package:rpg_self_improvement_app/data/repositories/character_experience/character_experience_repository.dart';

class CharacterExperienceRepositoryLocal extends CharacterExperienceRepository {
  static const _boxName = 'character_experience_box';

  Future<Box<int>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<int>(_boxName);
    }
    return await Hive.openBox<int>(_boxName);
  }

  @override
  Future<(int, int)> setUpInitialCharacterExperience() async {
    final box = await _openBox();
    await box.put('level', 1);
    await box.put('current_exp', 0);
    return (1, 0);
  }

  @override
  Future<(int?, int?)> fetchCharacterExperience() async {
    final box = await _openBox();
    final level = box.get('level');
    final currentExp = box.get('current_exp');
    return (level, currentExp);
  }

  @override
  Future<void> updateCharacterExperience(
    int newLevel,
    int newCurrentExp,
  ) async {
    final box = await _openBox();
    await box.put('level', newLevel);
    await box.put('current_exp', newCurrentExp);
  }
}
