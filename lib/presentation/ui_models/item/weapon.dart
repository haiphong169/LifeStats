import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

import 'item.dart';

class Weapon extends Item {
  final double attributeBonusExperience;
  final AttributeType attributeType;

  const Weapon({
    required super.name,
    required super.description,
    required super.imageUrl,
    super.isEquipped,
    required super.price,
    required this.attributeBonusExperience,
    required this.attributeType,
  });

  @override
  Weapon equippedItem() {
    return Weapon(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isEquipped: true,
      price: price,
      attributeBonusExperience: attributeBonusExperience,
      attributeType: attributeType,
    );
  }

  @override
  Weapon unequippedItem() {
    return Weapon(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isEquipped: false,
      price: price,
      attributeBonusExperience: attributeBonusExperience,
      attributeType: attributeType,
    );
  }
}
