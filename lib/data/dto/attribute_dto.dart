import 'package:hive_flutter/hive_flutter.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

part 'attribute_dto.g.dart';

@HiveType(typeId: 2)
class AttributeDto {
  @HiveField(0)
  final int level;
  @HiveField(1)
  final int currentExp;
  @HiveField(2)
  final AttributeType attributeType;

  const AttributeDto({
    required this.level,
    required this.currentExp,
    required this.attributeType,
  });

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'currentExp': currentExp,
      'attributeType': attributeType.name,
    };
  }

  factory AttributeDto.fromJson(Map<String, dynamic> json) {
    return AttributeDto(
      level: json['level'] as int,
      currentExp: json['currentExp'] as int,
      attributeType: AttributeType.values.byName(json['attributeType']),
    );
  }
}
