import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/data/repositories/character_experience/character_experience_repository.dart';

class ExpNotifier with ChangeNotifier {
  final CharacterExperienceRepository _repository;
  ExpNotifier(this._repository);

  int _level = 1;
  int _currentXp = 0;

  double get progress => _currentXp / xpForNextLevel;

  int get level => _level;
  int get currentXp => _currentXp;
  int get xpForNextLevel => 5 + 5 * _level * _level;

  Future<void> fetchCharacterExperience() async {
    var characterExperience = await _repository.fetchCharacterExperience();
    if (characterExperience.$1 == null || characterExperience.$2 == null) {
      characterExperience = await _repository.setUpInitialCharacterExperience();
    }

    _level = characterExperience.$1!;
    _currentXp = characterExperience.$2!;

    notifyListeners();
  }

  Future<void> gainXp(int amount) async {
    _currentXp += amount;

    if (_currentXp >= xpForNextLevel) {
      _currentXp -= xpForNextLevel;
      _level++;
    }

    await _repository.updateCharacterExperience(_level, _currentXp);

    notifyListeners();
  }
}
