import 'package:flutter/material.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/character_class/character_class_repository.dart';

class CharacterClassNotifier with ChangeNotifier {
  final CharacterClassRepository _repository;

  CharacterClassNotifier(this._repository);

  CharacterClass? _characterClass;
  int? _lastPickedAtAttributeLevel;

  CharacterClass? get characterClass => _characterClass;
  int? get lastPickedAtAttributeLevel => _lastPickedAtAttributeLevel;

  Future<void> fetchCharacterClass() async {
    final dto = await _repository.fetchCharacterClass();
    if (dto == null) {
      _characterClass = CharacterClass.normie;
      _lastPickedAtAttributeLevel = null;
    } else {
      _characterClass = dto.characterClass;
      _lastPickedAtAttributeLevel = dto.lastPickedAtAttributeLevel;
    }

    notifyListeners();
  }

  Future<void> saveCharacterClass(
    CharacterClass newClass,
    int? lastPickedLevel,
  ) async {
    await _repository.saveCharacterClass(
      CharacterClassDto(
        characterClass: newClass,
        lastPickedAtAttributeLevel: lastPickedLevel,
      ),
    );
    _characterClass = newClass;
    _lastPickedAtAttributeLevel = lastPickedLevel;

    notifyListeners();
  }
}
