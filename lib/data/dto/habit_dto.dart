import 'package:hive/hive.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

part 'habit_dto.g.dart';

@HiveType(typeId: 1)
class HabitDto {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int? lastCompletedTimestamp;
  @HiveField(4)
  final AttributeType attributeType;

  HabitDto({
    required this.id,
    required this.title,
    required this.description,
    this.lastCompletedTimestamp,
    required this.attributeType,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lastCompletedTimestamp': lastCompletedTimestamp,
      'attributeType': attributeType.name,
    };
  }

  factory HabitDto.fromJson(Map<String, dynamic> json) {
    return HabitDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      lastCompletedTimestamp: json['lastCompletedTimestamp'] as int?,
      attributeType: AttributeType.values.firstWhere(
        (e) => e.name == json['attributeType'],
      ),
    );
  }
}
