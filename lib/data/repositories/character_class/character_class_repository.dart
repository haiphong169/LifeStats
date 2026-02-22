import 'package:rpg_self_improvement_app/data/dto/character_class_dto.dart';

abstract class CharacterClassRepository {
  Future<CharacterClassDto?> fetchCharacterClass();
  Future<void> saveCharacterClass(CharacterClassDto characterClass);
}
