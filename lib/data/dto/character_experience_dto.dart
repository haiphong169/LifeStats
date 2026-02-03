import 'package:hive_flutter/hive_flutter.dart';

part 'character_experience_dto.g.dart';

@HiveType(typeId: 3)
class CharacterExperienceDto {
  @HiveField(0)
  final int level;
  @HiveField(1)
  final int currentExp;

  const CharacterExperienceDto({required this.level, required this.currentExp});

  Map<String, dynamic> toJson() {
    return {'level': level, 'currentExp': currentExp};
  }

  factory CharacterExperienceDto.fromJson(Map<String, dynamic> json) {
    return CharacterExperienceDto(
      level: json['level'] as int,
      currentExp: json['currentExp'] as int,
    );
  }
}
