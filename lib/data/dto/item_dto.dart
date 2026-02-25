import 'package:hive_flutter/hive_flutter.dart';

part 'item_dto.g.dart';

@HiveType(typeId: 6)
class ItemDto {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final bool isEquipped;

  const ItemDto({required this.name, required this.isEquipped});

  Map<String, dynamic> toJson() {
    return {'name': name, 'isEquipped': isEquipped};
  }

  factory ItemDto.fromJson(Map<String, dynamic> json) {
    return ItemDto(
      name: json['name'] as String,
      isEquipped: json['isEquipped'] as bool,
    );
  }
}
