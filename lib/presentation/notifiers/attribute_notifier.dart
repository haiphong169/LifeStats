import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:rpg_self_improvement_app/data/dto/attribute_dto.dart';
import 'package:rpg_self_improvement_app/data/repositories/attribute/attribute_repository.dart';
import 'package:rpg_self_improvement_app/presentation/ui_models/attribute.dart';
import 'package:rpg_self_improvement_app/utils/adapters/mapper_helper.dart';

class AttributeNotifier with ChangeNotifier {
  final AttributeRepository _repository;

  AttributeNotifier(this._repository);

  Map<AttributeType, Attribute> _gameAttributes = {};

  UnmodifiableMapView<AttributeType, Attribute> get gameAttributes =>
      UnmodifiableMapView(_gameAttributes);

  Future<void> fetchAttributes() async {
    var attributes = await _repository.fetchAttributes();
    if (attributes.isEmpty) {
      attributes = await _repository.setUpInitialAttributes();
    }

    _gameAttributes = {
      for (final attribute in attributes)
        attribute.attributeType: MapperHelper().fromAttributeDto(attribute),
    };
    notifyListeners();
  }

  Future<bool> gainAttributeExperience(int xpAmount, AttributeType type) async {
    var oldAttribute = _gameAttributes[type]!;
    final gainXpResult = oldAttribute.gainXp(xpAmount);
    final updatedAttribute = gainXpResult.$1;
    await _repository.updateAttributeExp(
      AttributeDto(
        level: updatedAttribute.level,
        currentExp: updatedAttribute.currentXp,
        attributeType: updatedAttribute.attributeType,
      ),
    );
    _gameAttributes[type] = updatedAttribute;

    notifyListeners();

    return gainXpResult.$2;
  }
}
