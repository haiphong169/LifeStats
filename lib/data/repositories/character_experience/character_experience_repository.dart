abstract class CharacterExperienceRepository {
  Future<(int, int)> setUpInitialCharacterExperience();
  Future<(int?, int?)> fetchCharacterExperience();
  Future<void> updateCharacterExperience(int newLevel, int newCurrentExp);
}
