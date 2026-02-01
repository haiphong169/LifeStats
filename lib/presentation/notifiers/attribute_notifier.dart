import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';

class AttributeNotifier with ChangeNotifier {
  // mình cần làm gì? nền data cho 4 chỉ số
  // hiển thị 4 stat cùng với level và thanh kinh nghiệm
  final Map<AttributeType, Attribute> _gameAttributes = {
    AttributeType.strength: Attribute(attributeType: AttributeType.strength),
    AttributeType.intelligence: Attribute(
      attributeType: AttributeType.intelligence,
    ),
    AttributeType.luck: Attribute(attributeType: AttributeType.luck),
    AttributeType.charisma: Attribute(attributeType: AttributeType.charisma),
  };

  UnmodifiableMapView<AttributeType, Attribute> get gameAttributes =>
      UnmodifiableMapView(_gameAttributes);

  bool gainAttributeExperience(int xpAmount, AttributeType type) {
    var oldAttribute = _gameAttributes[type]!;
    final gainXpResult = oldAttribute.gainXp(xpAmount);
    _gameAttributes[type] = gainXpResult.$1;

    notifyListeners();

    return gainXpResult.$2;
  }
}
