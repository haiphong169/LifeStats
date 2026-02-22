import 'package:hive_flutter/hive_flutter.dart';
import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/character_class/character_class_repository.dart';

class CharacterClassRepositoryLocal extends CharacterClassRepository {
  static const _boxName = "character_class_box";

  Future<Box<CharacterClassDto>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<CharacterClassDto>(_boxName);
    }
    return await Hive.openBox<CharacterClassDto>(_boxName);
  }

  @override
  Future<CharacterClassDto?> fetchCharacterClass() async {
    final box = await _openBox();
    return box.get('character_class');
  }

  @override
  Future<void> saveCharacterClass(CharacterClassDto characterClass) async {
    final box = await _openBox();
    await box.put('character_class', characterClass);
  }
}
